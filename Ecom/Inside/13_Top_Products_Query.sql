SELECT 
    p.name AS product_name,
    ROUND(SUM(vld.qty_available)) AS current_stock,
    IFNULL(b.total_current_sale, 0) AS total_current_sale,
    IFNULL(b.total_sale_amount, 0) AS total_sale_amount,
    IFNULL(c.total_previous_sale, 0) AS total_previous_sale,
    ROUND(
        CASE 
            WHEN IFNULL(c.total_previous_sale, 0) = 0 THEN 0
            ELSE (IFNULL(b.total_current_sale, 0) - IFNULL(c.total_previous_sale, 0)) / IFNULL(c.total_previous_sale, 1) * 100
        END, 2
    ) AS percentage_change
FROM products AS p
-- Join with the current sales data for the fixed products
LEFT JOIN (
    SELECT 
        od.product_id,
        ROUND(SUM(od.quantity)) AS total_current_sale,
        ROUND(SUM(od.quantity * od.price)) AS total_sale_amount
    FROM 
        order_details AS od
    WHERE 
        DATE(od.created_at) BETWEEN '2025-01-10' AND '2025-01-11'
    GROUP BY 
        od.product_id
) AS b ON p.id = b.product_id
-- Join with previous sales data for the fixed products
LEFT JOIN (
    SELECT 
        od.product_id,
        ROUND(SUM(od.quantity)) AS total_previous_sale
    FROM 
        order_details AS od
    WHERE 
        DATE(od.created_at) BETWEEN '2025-01-02' AND '2025-01-09'
    GROUP BY 
        od.product_id
) AS c ON p.id = c.product_id
-- Join with the variation_location_details for current stock
LEFT JOIN qatar_pos_db.variation_location_details AS vld ON p.id = vld.product_id
GROUP BY 
    p.id
HAVING 
    total_current_sale > 0
ORDER BY 
    total_current_sale DESC
LIMIT 1000;

------------------------------------------------ Top Products Search By Brand, Category, Products---------------------------------------------

SELECT 
    p.name AS product_name,
    ROUND(SUM(vld.qty_available)) AS current_stock,
    IFNULL(b.total_current_sale, 0) AS total_current_sale,
    IFNULL(b.total_sale_amount, 0) AS total_sale_amount,
    IFNULL(c.total_previous_sale, 0) AS total_previous_sale,
    ROUND(
        CASE 
            WHEN IFNULL(c.total_previous_sale, 0) = 0 THEN 0
            ELSE (IFNULL(b.total_current_sale, 0) - IFNULL(c.total_previous_sale, 0)) / IFNULL(c.total_previous_sale, 1) * 100
        END, 2
    ) AS percentage_change
FROM products AS p
-- Join with the current sales data for the fixed products
LEFT JOIN (
    SELECT 
        od.product_id,
        ROUND(SUM(od.quantity)) AS total_current_sale,
        ROUND(SUM(od.quantity * od.price)) AS total_sale_amount
    FROM 
        order_details AS od
    WHERE 
        DATE(od.created_at) BETWEEN '2025-01-10' AND '2025-01-11'
    GROUP BY 
        od.product_id
) AS b ON p.id = b.product_id
-- Join with previous sales data for the fixed products
LEFT JOIN (
    SELECT 
        od.product_id,
        ROUND(SUM(od.quantity)) AS total_previous_sale
    FROM 
        order_details AS od
    WHERE 
        DATE(od.created_at) BETWEEN '2025-01-02' AND '2025-01-09'
    GROUP BY 
        od.product_id
) AS c ON p.id = c.product_id
-- Join with the variation_location_details for current stock
LEFT JOIN qatar_pos_db.variation_location_details AS vld ON p.id = vld.product_id
WHERE 
	--p.brand_id=14
	--p.category_id=255
	p.id=136
GROUP BY 
    p.id
HAVING 
    total_current_sale > 0
ORDER BY 
    total_current_sale DESC;
