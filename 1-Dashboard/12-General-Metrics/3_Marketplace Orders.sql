	SELECT 
	COUNT(*) AS marketplace_orders
FROM 
	pos.transactions
WHERE vendor_id IN (2,3,5)
	AND type = 'sell'
    AND DATE(created_at) >= '2025-05-10' AND DATE(created_at) <= '2025-05-10'