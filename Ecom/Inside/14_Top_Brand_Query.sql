SELECT 
    b.name AS brand_name,
    ROUND(COUNT(p.id)) AS total_product,
    IFNULL(SUM(s.total_current_sale), 0) AS total_current_sale,
    IFNULL(SUM(s.total_sale_amount), 0) AS total_sale_amount,
    IFNULL(SUM(ps.previous_total_sale), 0) AS total_previous_sale,
    ROUND(
        CASE 
            WHEN IFNULL(SUM(ps.previous_total_sale), 0) = 0 THEN 0
            ELSE (IFNULL(SUM(s.total_current_sale), 0) - IFNULL(SUM(ps.previous_total_sale), 0)) / IFNULL(SUM(ps.previous_total_sale), 1) * 100
        END, 2
    ) AS percentage_change
FROM brands AS b
-- Join with products to get product details
JOIN products AS p ON p.brand_id = b.id
-- Join with the current sales data for the fixed products
LEFT JOIN (
    SELECT 
        od.product_id,
        ROUND(SUM(od.quantity)) AS total_current_sale,
        ROUND(SUM(od.quantity * od.price)) AS total_sale_amount
    FROM 
        order_details AS od
    WHERE 
        DATE(od.created_at) BETWEEN '2025-01-11' AND '2025-01-12'
    GROUP BY 
        od.product_id
) AS s ON p.id = s.product_id
-- Join with previous sales data for the fixed products
LEFT JOIN (
    SELECT 
        od.product_id,
        ROUND(SUM(od.quantity)) AS previous_total_sale
    FROM 
        order_details AS od
    WHERE 
        DATE(od.created_at) BETWEEN '2025-01-09' AND '2025-01-10'
    GROUP BY 
        od.product_id
) AS ps ON p.id = ps.product_id

GROUP BY 
    b.id
ORDER BY 
    total_current_sale DESC;
------------------------------------------ Search Brand,Category & Products ---------------------------------------------
SELECT 
    b.name AS brand_name,
    ROUND(COUNT(p.id)) AS total_product,
    IFNULL(SUM(s.total_current_sale), 0) AS total_current_sale,
    IFNULL(SUM(s.total_sale_amount), 0) AS total_sale_amount,
    IFNULL(SUM(ps.previous_total_sale), 0) AS total_previous_sale,
    ROUND(
        CASE 
            WHEN IFNULL(SUM(ps.previous_total_sale), 0) = 0 THEN 0
            ELSE (IFNULL(SUM(s.total_current_sale), 0) - IFNULL(SUM(ps.previous_total_sale), 0)) / IFNULL(SUM(ps.previous_total_sale), 1) * 100
        END, 2
    ) AS percentage_change
FROM brands AS b
-- Join with products to get product details
JOIN products AS p ON p.brand_id = b.id
-- Join with the current sales data for the fixed products
LEFT JOIN (
    SELECT 
        od.product_id,
        ROUND(SUM(od.quantity)) AS total_current_sale,
        ROUND(SUM(od.quantity * od.price)) AS total_sale_amount
    FROM 
        order_details AS od
    WHERE 
        DATE(od.created_at) BETWEEN '2025-01-11' AND '2025-01-12'
    GROUP BY 
        od.product_id
) AS s ON p.id = s.product_id
-- Join with previous sales data for the fixed products
LEFT JOIN (
    SELECT 
        od.product_id,
        ROUND(SUM(od.quantity)) AS previous_total_sale
    FROM 
        order_details AS od
    WHERE 
        DATE(od.created_at) BETWEEN '2025-01-09' AND '2025-01-10'
    GROUP BY 
        od.product_id
) AS ps ON p.id = ps.product_id
WHERE 
 --p.id=136
 --p.category_id=255
 --p.brand_id=14
GROUP BY 
    b.id
ORDER BY 
    total_current_sale DESC;