WITH sales_data AS (
    SELECT 
        p.id AS product_id,
        p.name AS product_name,
        ROUND(vld.qty_available) AS current_stock,
        ROUND(SUM(tsl.quantity)) AS total_sale, -- Ensure total_sale is rounded to an integer
        SUM(tsl.quantity * tsl.unit_price_inc_tax) AS total_sale_amount
    FROM 
        products p
    LEFT JOIN 
        variation_location_details vld ON p.id = vld.product_id
    LEFT JOIN 
        transaction_sell_lines tsl ON p.id = tsl.product_id
    WHERE 
        p.business_id = 1
		AND p.brand_id !=14
        AND vld.location_id = 1
        AND DATE(tsl.created_at) >= '2024-12-20'
        AND DATE(tsl.created_at) <= '2024-12-31'
    GROUP BY 
        p.id, p.name, vld.qty_available
),
ranked_sales AS (
    SELECT 
        product_id,
        product_name,
        current_stock,
        total_sale,
        total_sale_amount,
        LAG(total_sale) OVER (ORDER BY total_sale DESC) AS prev_total_sale
    FROM 
        sales_data
)
SELECT 
    product_id,
    product_name,
    current_stock,
    total_sale, -- Rounded to an integer in the CTE
    CASE 
        WHEN total_sale_amount = ROUND(total_sale_amount) THEN CAST(total_sale_amount AS SIGNED)
        ELSE ROUND(total_sale_amount, 2)
    END AS total_sale_amount,
    CASE 
        WHEN total_sale > 0 AND prev_total_sale IS NOT NULL THEN 
            ROUND((total_sale - prev_total_sale) / prev_total_sale * 100, 2)
        ELSE 0
    END AS sale_comparison
FROM 
    ranked_sales
ORDER BY 
    total_sale DESC, product_id DESC
LIMIT 1000;