SELECT 
    p.id AS product_id, 
    p.name AS product_name, 
    COUNT(tsl.product_id) AS orders,
    ROUND(COALESCE(SUM(tsl.quantity * tsl.unit_price), 0)) AS amount,
    ROUND(
        COALESCE(
            (
                (
                    SELECT COUNT(*) 
                    FROM pos.transaction_sell_lines AS od_new
                    WHERE ts.vendor_id IN (2,3,5)
                    AND ts.type = 'sell'
                    AND DATE(od_new.created_at) BETWEEN '2025-03-05' AND '2025-03-06'
                    AND od_new.product_id = p.id
                ) - 
                (
                    SELECT COUNT(*) 
                    FROM pos.transaction_sell_lines AS od_old
                    WHERE ts.vendor_id IN (2,3,5)
                    AND ts.type = 'sell'
                    AND DATE(od_old.created_at) BETWEEN '2025-03-03' AND '2025-03-04'
                    AND od_old.product_id = p.id
                )
            ) / NULLIF(
                (
                    SELECT COUNT(*) 
                    FROM pos.transaction_sell_lines AS od_old
                    WHERE ts.vendor_id IN (2,3,5)
                    AND ts.type = 'sell'
                    AND DATE(od_old.created_at) BETWEEN '2025-03-03' AND '2025-03-04'
                    AND od_old.product_id = p.id
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
WHERE 
    ts.vendor_id IN (2,3,5)
AND ts.type = 'sell'
AND DATE(tsl.created_at) BETWEEN '2025-03-05' AND '2025-03-06'
GROUP BY 
    p.id, p.name, ts.vendor_id
ORDER BY 
    orders DESC

------------------------------------------ Search Brand,Category ---------------------------------------------
SELECT 
    p.id AS product_id, 
    p.name AS product_name, 
    COUNT(tsl.product_id) AS orders,
    ROUND(COALESCE(SUM(tsl.quantity * tsl.unit_price), 0)) AS amount,
    ROUND(
        COALESCE(
            (
                (
                    SELECT COUNT(*) 
                    FROM pos.transaction_sell_lines AS od_new
                    WHERE ts.vendor_id IN (2,3,5)
                    AND ts.type = 'sell'
                    AND DATE(od_new.created_at) BETWEEN '2025-03-05' AND '2025-03-06'
                    AND od_new.product_id = p.id
                ) - 
                (
                    SELECT COUNT(*) 
                    FROM pos.transaction_sell_lines AS od_old
                    WHERE ts.vendor_id IN (2,3,5)
                    AND ts.type = 'sell'
                    AND DATE(od_old.created_at) BETWEEN '2025-03-03' AND '2025-03-04'
                    AND od_old.product_id = p.id
                )
            ) / NULLIF(
                (
                    SELECT COUNT(*) 
                    FROM pos.transaction_sell_lines AS od_old
                    WHERE ts.vendor_id IN (2,3,5)
                    AND ts.type = 'sell'
                    AND DATE(od_old.created_at) BETWEEN '2025-03-03' AND '2025-03-04'
                    AND od_old.product_id = p.id
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
WHERE 
    ts.vendor_id IN (2,3,5)
AND ts.type = 'sell'
AND DATE(tsl.created_at) BETWEEN '2025-03-05' AND '2025-03-05'
	--AND p.category_id=255
	--AND p.brand_id=14
GROUP BY 
    p.id, p.name, ts.vendor_id
ORDER BY 
    orders DESC
	