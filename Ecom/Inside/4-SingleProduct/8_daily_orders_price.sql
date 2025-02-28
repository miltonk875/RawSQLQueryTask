-------------------------------------------- Daily Orders & Prices ------------------------------------------
--Demo 1
SELECT 
    DATE(ts.created_at) AS order_date,
    COUNT(DISTINCT ts.id) AS total_orders,
    FORMAT(COALESCE(SUM(ts.final_total), 0), 2) AS total_amount
FROM 
    pos.transaction_sell_lines AS tsl
JOIN 
	pos.transactions ts ON tsl.transaction_id = ts.id
WHERE 
	ts.business_id = 1 
	AND ts.location_id = 1 
	AND ts.created_by = 1 
	AND ts.type = 'sell' 
	AND tsl.product_id = 136
	AND DATE(ts.created_at) BETWEEN '2025-02-25' AND '2025-02-28'
GROUP BY 
    order_date;
	
--Demo 2

SELECT 
    DATE(ts.created_at) AS order_date,
    COUNT(DISTINCT ts.id) AS total_orders,
    FORMAT(COALESCE(SUM(ts.final_total), 0), 2) AS total_amount
FROM 
    pos.transaction_sell_lines AS tsl
JOIN 
	pos.transactions ts ON tsl.transaction_id = ts.id
WHERE 
	vendor_id IN (2,3,5)
	AND tsl.product_id = 136
	AND DATE(ts.created_at) BETWEEN '2025-02-25' AND '2025-02-28'
GROUP BY 
    order_date;
	
-- Final Use below this query 
	
SELECT 
    DATE(ts.created_at) AS order_date,
    COUNT(DISTINCT ts.id) AS total_orders,
    FORMAT(COALESCE(SUM(ts.final_total), 0), 2) AS total_amount
FROM 
    pos.transaction_sell_lines AS tsl
JOIN 
    pos.transactions ts ON tsl.transaction_id = ts.id
WHERE 
    tsl.product_id = 136
    AND DATE(ts.created_at) BETWEEN '2025-02-25' AND '2025-02-28'
    AND (
        (ts.business_id = 1 AND ts.location_id = 1 AND ts.created_by = 1 AND ts.type = 'sell')
        OR
        (vendor_id IN (2,3,5))
    )
GROUP BY 
    order_date;
