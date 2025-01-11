SELECT 
    p.name AS product_name,
    ROUND(SUM(vld.qty_available)) AS current_stock,
    b.total_sale,
    b.total_sale_amount,
    IFNULL(c.previous_total_sale, 0) AS previous_total_sale,
    ROUND(
        CASE 
            WHEN IFNULL(c.previous_total_sale, 0) = 0 THEN NULL
            ELSE (b.total_sale - c.previous_total_sale) / c.previous_total_sale * 100
        END, 2
    ) AS percentage_change
FROM (
    -- Current sales (December 2024)
    SELECT 
        tsl.product_id,
        ROUND(SUM(tsl.quantity)) AS total_sale,
        ROUND(SUM(tsl.quantity * tsl.unit_price)) AS total_sale_amount
    FROM 
        qatar_pos_db.transaction_sell_lines AS tsl
    WHERE 
        tsl.transaction_id IN (
            SELECT id 
            FROM qatar_pos_db.transactions 
            WHERE location_id = 1 
            AND type = 'sell'
        )
        AND DATE(tsl.created_at) >= '2024-12-01'
        AND DATE(tsl.created_at) <= '2024-12-31'
    GROUP BY 
        tsl.product_id
) AS b
-- Join previous sales (November 2024)
LEFT JOIN (
    SELECT 
        tsl.product_id,
        ROUND(SUM(tsl.quantity)) AS previous_total_sale
    FROM 
        qatar_pos_db.transaction_sell_lines AS tsl
    WHERE 
        tsl.transaction_id IN (
            SELECT id 
            FROM qatar_pos_db.transactions 
            WHERE location_id = 1 
            AND type = 'sell'
        )
        AND DATE(tsl.created_at) >= '2024-11-01'
        AND DATE(tsl.created_at) <= '2024-11-30'
    GROUP BY 
        tsl.product_id
) AS c ON b.product_id = c.product_id
-- Join additional tables
JOIN qatar_ecommerce_db.products AS p ON p.id = b.product_id
JOIN qatar_ecommerce_db.brands AS br ON p.brand_id = br.id
JOIN qatar_ecommerce_db.categories AS c2 ON p.category_id = c2.id
JOIN qatar_pos_db.variation_location_details AS vld ON vld.product_id = p.id

WHERE p.category_id=255

GROUP BY 
    p.id
ORDER BY 
    b.total_sale DESC;
