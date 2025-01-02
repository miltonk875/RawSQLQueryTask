WITH sales_data AS (
    SELECT 
        p.brand_id AS brand_id,
        b.name AS brand_name,  
        ROUND(vld.qty_available) AS current_stock, 
        SUM(tsl.quantity) AS total_sale, 
        SUM(tsl.quantity * tsl.unit_price_inc_tax) AS total_sale_amount
    FROM 
        products p
    LEFT JOIN 
        transaction_sell_lines tsl ON p.id = tsl.product_id
    LEFT JOIN 
        brands b ON p.brand_id = b.id
    WHERE 
        p.business_id = 1 
        AND vld.location_id = 1
        AND DATE(tsl.created_at) >= '2024-12-20'
        AND DATE(tsl.created_at) <= '2024-12-31'
    GROUP BY 
        p.brand_id, b.name, vld.qty_available
),
ranked_sales AS (
    SELECT 
        brand_id, 
        brand_name, 
        current_stock, 
        total_sale, 
        total_sale_amount,
        LAG(total_sale) OVER (ORDER BY total_sale DESC) AS prev_total_sale
    FROM 
        sales_data
)
SELECT 
    brand_id, 
    brand_name, 
    current_stock, 
    total_sale, 
    ROUND(total_sale_amount, 2) AS total_sale_amount,
    CASE 
        WHEN total_sale > 0 AND prev_total_sale IS NOT NULL THEN 
            ROUND((total_sale - prev_total_sale) / prev_total_sale * 100, 2)
        ELSE 0
    END AS sale_comparison
FROM 
    ranked_sales
ORDER BY 
    total_sale DESC, brand_id DESC
LIMIT 1000;


------------- Brand Wise Products--------------
SELECT 
    b.name AS brand_name,
    COUNT(p.id) AS total_brand_wise_products
FROM 
    brands b
LEFT JOIN 
    products p ON b.id = p.brand_id
WHERE 
    b.business_id = 1
GROUP BY 
    b.id, b.name
ORDER BY 
    total_brand_wise_products DESC;


SELECT 
    b.name AS brand_name,
    COUNT(p.id) AS total_brand_wise_products,  -- Count of products for each brand
    SUM(tsl.quantity) AS brand_wise_sales  -- Total sales (quantity sold) for each brand
FROM 
    brands b
LEFT JOIN 
    products p ON b.id = p.brand_id
LEFT JOIN 
    transaction_sell_lines tsl ON p.id = tsl.product_id
WHERE 
    b.business_id = 1  -- Replace with your business ID filter
GROUP BY 
    b.id, b.name
ORDER BY 
    brand_wise_sales DESC,  -- Optional: Sort by total sales in descending order
    total_brand_wise_products DESC;  -- Optional: Sort by total products in descending order
