SELECT 
    b.id AS brand_id, 
    b.name AS brand_name, 
    COUNT(tsl.id) AS orders,
    ROUND(COALESCE(SUM(tsl.quantity * tsl.unit_price), 0)) AS amount,
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
                    AND od_new.product_id IN (SELECT id FROM pos.products WHERE brand_id = b.id)
                ) - 
                (
                    SELECT COUNT(*) 
                    FROM pos.transaction_sell_lines AS od_old
                    JOIN pos.transactions ts_old ON od_old.transaction_id = ts_old.id
                    WHERE ts_old.vendor_id IN (2,3,5)
                    AND ts_old.type = 'sell'
                    AND DATE(od_old.created_at) BETWEEN '2025-03-03' AND '2025-03-04'
                    AND od_old.product_id IN (SELECT id FROM pos.products WHERE brand_id = b.id)
                )
            ) / NULLIF(
                (
                    SELECT COUNT(*) 
                    FROM pos.transaction_sell_lines AS od_old
                    JOIN pos.transactions ts_old ON od_old.transaction_id = ts_old.id
                    WHERE ts_old.vendor_id IN (2,3,5)
                    AND ts_old.type = 'sell'
                    AND DATE(od_old.created_at) BETWEEN '2025-03-03' AND '2025-03-04'
                    AND od_old.product_id IN (SELECT id FROM pos.products WHERE brand_id = b.id)
                ), 0
            ) * 100, 0.00
        ), 2
    ) AS percentage_change
FROM 
    pos.transaction_sell_lines tsl
JOIN 
    pos.transactions ts ON tsl.transaction_id = ts.id
JOIN 
    pos.products p ON tsl.product_id = p.id
JOIN 
    pos.brands b ON p.brand_id = b.id
WHERE 
    ts.vendor_id IN (2,3,5)
AND ts.type = 'sell'
AND DATE(tsl.created_at) BETWEEN '2025-03-05' AND '2025-03-06'
GROUP BY 
    b.id, b.name
ORDER BY 
    orders DESC
    
------------------------------------------ Search Brand,Category ---------------------------------------------
SELECT 
    b.id AS brand_id, 
    b.name AS brand_name, 
    COUNT(tsl.id) AS orders,
    ROUND(COALESCE(SUM(tsl.quantity * tsl.unit_price), 0)) AS amount,
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
                    AND od_new.product_id IN (SELECT id FROM pos.products WHERE brand_id = b.id)
                ) - 
                (
                    SELECT COUNT(*) 
                    FROM pos.transaction_sell_lines AS od_old
                    JOIN pos.transactions ts_old ON od_old.transaction_id = ts_old.id
                    WHERE ts_old.vendor_id IN (2,3,5)
                    AND ts_old.type = 'sell'
                    AND DATE(od_old.created_at) BETWEEN '2025-03-03' AND '2025-03-04'
                    AND od_old.product_id IN (SELECT id FROM pos.products WHERE brand_id = b.id)
                )
            ) / NULLIF(
                (
                    SELECT COUNT(*) 
                    FROM pos.transaction_sell_lines AS od_old
                    JOIN pos.transactions ts_old ON od_old.transaction_id = ts_old.id
                    WHERE ts_old.vendor_id IN (2,3,5)
                    AND ts_old.type = 'sell'
                    AND DATE(od_old.created_at) BETWEEN '2025-03-03' AND '2025-03-04'
                    AND od_old.product_id IN (SELECT id FROM pos.products WHERE brand_id = b.id)
                ), 0
            ) * 100, 0.00
        ), 2
    ) AS percentage_change
FROM 
    pos.transaction_sell_lines tsl
JOIN 
    pos.transactions ts ON tsl.transaction_id = ts.id
JOIN 
    pos.products p ON tsl.product_id = p.id
JOIN 
    pos.brands b ON p.brand_id = b.id
WHERE 
    ts.vendor_id IN (2,3,5)
AND ts.type = 'sell'
AND DATE(tsl.created_at) BETWEEN '2025-03-05' AND '2025-03-06'
	--AND p.id=136
	--AND p.category_id=255
	--AND p.brand_id=14
GROUP BY 
    b.id, b.name
ORDER BY 
    orders DESC