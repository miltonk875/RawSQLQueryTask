--------------------------------------------Ecom & Market Palce Chart  ------------------------------------------	
--Demo 1
SELECT 
    DATE(ts.created_at) AS order_date,
	FORMAT(COALESCE(SUM(tsl.quantity), 0), 0) AS total_ecom_sold

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
	FORMAT(COALESCE(SUM(tsl.quantity), 0), 0) AS total_market_sold
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
	
--Final Query for Use
	
SELECT 
    DATE(ts.created_at) AS order_date,
    FORMAT(COALESCE(SUM(CASE 
        WHEN ts.business_id = 1 AND ts.location_id = 1 AND ts.created_by = 1 AND ts.type = 'sell' 
        THEN tsl.quantity ELSE 0 END), 0), 0) AS total_ecom_sold,
    FORMAT(COALESCE(SUM(CASE 
        WHEN vendor_id IN (2,3,5) 
        THEN tsl.quantity ELSE 0 END), 0), 0) AS total_market_sold
FROM 
    pos.transaction_sell_lines AS tsl
JOIN 
    pos.transactions ts ON tsl.transaction_id = ts.id
WHERE 
    tsl.product_id = 136
    AND DATE(ts.created_at) BETWEEN '2025-02-25' AND '2025-02-28'
GROUP BY 
    order_date;