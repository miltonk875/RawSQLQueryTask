WITH sales_data AS (
    SELECT 
        p.id AS product_id,
        p.name AS product_name,
        ROUND(vld.qty_available) AS current_stock,
        ROUND(SUM(tsl.quantity)) AS total_sale,
        SUM(tsl.quantity * tsl.unit_price_inc_tax) AS total_sale_amount
    FROM 
        products p
    LEFT JOIN 
        variation_location_details vld ON p.id = vld.product_id
    LEFT JOIN 
        transaction_sell_lines tsl ON p.id = tsl.product_id
    WHERE 
        p.business_id = 1
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
    total_sale, 
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



------------- Top Products New SQL Query--------------
SELECT 
    b.product_id,
    p.name,
    CONCAT("https://beautyboothqa.com/product/", p.slug) AS url,
    b.total_sell,
    b.total_sell_amount,
    round(SUM(vld.qty_available)) AS qty_available,
    c.name AS category,
    br.name AS brand
FROM (
    SELECT 
        tsl.product_id,
        round(SUM(tsl.quantity)) AS total_sell,
        round(SUM(tsl.quantity*tsl.unit_price)) AS total_sell_amount
    FROM 
        qatar_pos_db.transaction_sell_lines AS tsl
    WHERE 
        tsl.transaction_id IN (
            SELECT id 
            FROM qatar_pos_db.transactions 
            WHERE location_id = 1 
              AND type = 'sell'
        )
        AND DATE(tsl.created_at) >='2024-12-01'
        AND DATE(tsl.created_at) <='2024-12-31'
    GROUP BY 
        tsl.product_id
) AS b
JOIN qatar_ecommerce_db.products AS p ON p.id = b.product_id
JOIN qatar_ecommerce_db.brands AS br ON p.brand_id = br.id
JOIN qatar_ecommerce_db.categories AS c ON p.category_id = c.id
JOIN qatar_pos_db.variation_location_details AS vld ON vld.product_id = p.id
GROUP BY 
    p.id
ORDER BY 
    b.total_sell DESC;
