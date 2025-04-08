SELECT  
    p.id AS product_id,
    p.name AS product_name,
    b.name AS brand,
    c.name AS category,
	ROUND(SUM(vld.qty_available)) AS stock,
    FORMAT(ROUND(AVG(tsl.unit_price), 2), 2) AS unit_price,
    COUNT(tsl.product_id) AS current_order,
    ROUND(COALESCE(SUM(tsl.quantity * tsl.unit_price), 0)) AS order_amount,
	IFNULL(t.total_sold, 0) AS total_sold,
    ROUND(
        COALESCE(
            (
                (
                    SELECT COUNT(*)  
                    FROM pos.transaction_sell_lines AS od_new
                    JOIN pos.transactions ts_new ON od_new.transaction_id = ts_new.id
                    WHERE ts_new.vendor_id IN (2,3,5)
                    AND ts_new.type = 'sell'
                    AND DATE(od_new.created_at) BETWEEN '2025-03-05' AND '2025-03-06'
                    AND od_new.product_id = p.id
                ) -  
                (
                    SELECT COUNT(*)  
                    FROM pos.transaction_sell_lines AS od_old
                    JOIN pos.transactions ts_old ON od_old.transaction_id = ts_old.id
                    WHERE ts_old.vendor_id IN (2,3,5)
                    AND ts_old.type = 'sell'
                    AND DATE(od_old.created_at) BETWEEN '2025-03-03' AND '2025-03-04'
                    AND od_old.product_id = p.id
                )
            ) / NULLIF(
                (
                    SELECT COUNT(*)  
                    FROM pos.transaction_sell_lines AS od_old
                    JOIN pos.transactions ts_old ON od_old.transaction_id = ts_old.id
                    WHERE ts_old.vendor_id IN (2,3,5)
                    AND ts_old.type = 'sell'
                    AND DATE(od_old.created_at) BETWEEN '2025-03-03' AND '2025-03-04'
                    AND od_old.product_id = p.id
                ), 0
            ) * 100, 0.00
        ), 2
    ) AS trend
FROM  
    pos.transaction_sell_lines tsl
JOIN  
    pos.transactions ts ON tsl.transaction_id = ts.id
JOIN  
    pos.products p ON tsl.product_id = p.id
JOIN  
    pos.categories AS c ON p.category_id = c.id
JOIN  
    pos.brands AS b ON p.brand_id = b.id
JOIN 
	pos.variation_location_details AS vld ON tsl.product_id = vld.product_id
	
LEFT JOIN (
    SELECT 
        tsl.product_id,
        ROUND(SUM(tsl.quantity)) AS total_sold
    FROM 
        pos.transaction_sell_lines tsl
    GROUP BY 
        tsl.product_id
) AS t ON p.id = t.product_id

WHERE  
    ts.vendor_id IN (2,3,5)
AND ts.type = 'sell'
AND DATE(tsl.created_at) BETWEEN '2025-03-07' AND '2025-03-08'
GROUP BY  
    p.id, p.name, b.name, c.name
ORDER BY  
    current_order DESC
LIMIT 500;
 
------------------------------------------------------ Filter Wise Products --------------------------------------------------
SELECT  
    p.id AS product_id,
    p.name AS product_name,
    b.name AS brand,
    c.name AS category,
	ROUND(SUM(vld.qty_available)) AS stock,
    FORMAT(ROUND(AVG(tsl.unit_price), 2), 2) AS unit_price,
    COUNT(tsl.product_id) AS current_order,
    ROUND(COALESCE(SUM(tsl.quantity * tsl.unit_price), 0)) AS order_amount,
	IFNULL(t.total_sold, 0) AS total_sold,
    ROUND(
        COALESCE(
            (
                (
                    SELECT COUNT(*)  
                    FROM pos.transaction_sell_lines AS od_new
                    JOIN pos.transactions ts_new ON od_new.transaction_id = ts_new.id
                    WHERE ts_new.vendor_id=2
                    AND ts_new.type = 'sell'
                    AND DATE(od_new.created_at) BETWEEN '2025-03-05' AND '2025-03-06'
                    AND od_new.product_id = p.id
                ) -  
                (
                    SELECT COUNT(*)  
                    FROM pos.transaction_sell_lines AS od_old
                    JOIN pos.transactions ts_old ON od_old.transaction_id = ts_old.id
                    WHERE ts_old.vendor_id=2
                    AND ts_old.type = 'sell'
                    AND DATE(od_old.created_at) BETWEEN '2025-03-03' AND '2025-03-04'
                    AND od_old.product_id = p.id
                )
            ) / NULLIF(
                (
                    SELECT COUNT(*)  
                    FROM pos.transaction_sell_lines AS od_old
                    JOIN pos.transactions ts_old ON od_old.transaction_id = ts_old.id
                    WHERE ts_old.vendor_id=2
                    AND ts_old.type = 'sell'
                    AND DATE(od_old.created_at) BETWEEN '2025-03-03' AND '2025-03-04'
                    AND od_old.product_id = p.id
                ), 0
            ) * 100, 0.00
        ), 2
    ) AS trend
FROM  
    pos.transaction_sell_lines tsl
JOIN  
    pos.transactions ts ON tsl.transaction_id = ts.id
JOIN  
    pos.products p ON tsl.product_id = p.id
JOIN  
    pos.categories AS c ON p.category_id = c.id
JOIN  
    pos.brands AS b ON p.brand_id = b.id
JOIN 
	pos.variation_location_details AS vld ON tsl.product_id = vld.product_id
	
LEFT JOIN (
    SELECT 
        tsl.product_id,
        ROUND(SUM(tsl.quantity)) AS total_sold
    FROM 
        pos.transaction_sell_lines tsl
    GROUP BY 
        tsl.product_id
) AS t ON p.id = t.product_id

WHERE  
    ts.vendor_id=2
AND ts.type = 'sell'
AND DATE(tsl.created_at) BETWEEN '2025-03-07' AND '2025-03-08'
GROUP BY  
    p.id, p.name, b.name, c.name
ORDER BY  
    current_order DESC
LIMIT 500;