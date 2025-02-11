SELECT 
    p.id,
    p.name AS name,
    b.name AS brand,
    c.name AS category,
    ROUND(SUM(vld.qty_available)) AS stock,
    p.unit_price AS unit_price,
    IFNULL(b.current_order, 0) AS current_order,
    IFNULL(c.previous_sale, 0) AS previous_sale,
    IFNULL(t.total_sold, 0) AS total_sold,
    ROUND(
        CASE 
            WHEN IFNULL(c.previous_sale, 0) = 0 THEN 0
            ELSE (IFNULL(b.current_order, 0) - IFNULL(c.previous_sale, 0)) / NULLIF(IFNULL(c.previous_sale, 1), 0) * 100
        END, 2
    ) AS trend
FROM products AS p
LEFT JOIN categories AS c ON p.category_id = c.id
LEFT JOIN brands AS b ON p.brand_id = b.id

-- Subquery for current orders within a specific date range
LEFT JOIN (
    SELECT 
        od.product_id,
        ROUND(SUM(od.quantity)) AS current_order
    FROM 
        order_details AS od
    WHERE 
        DATE(od.created_at) BETWEEN '2025-01-22' AND '2025-01-23'
    GROUP BY 
        od.product_id
) AS b ON p.id = b.product_id

-- Subquery for previous sales data for the fixed products
LEFT JOIN (
    SELECT 
        od.product_id,
        ROUND(SUM(od.quantity)) AS previous_sale
    FROM 
        order_details AS od
    WHERE 
        DATE(od.created_at) BETWEEN '2025-01-20' AND '2025-01-21'
    GROUP BY 
        od.product_id
) AS c ON p.id = c.product_id

-- Subquery for total_sold over the entire time range
LEFT JOIN (
    SELECT 
        od.product_id,
        ROUND(SUM(od.quantity)) AS total_sold
    FROM 
        order_details AS od
    GROUP BY 
        od.product_id
) AS t ON p.id = t.product_id

-- Join with variation_location_details for current stock
LEFT JOIN qatar_pos_db.variation_location_details AS vld ON p.id = vld.product_id

WHERE 
	vld.location_id = 1;
AND
    -- p.category_id = 136
    -- p.brand_id = 136

GROUP BY 
    p.id
HAVING 
    current_order > 0
ORDER BY 
    current_order DESC
LIMIT 1000;