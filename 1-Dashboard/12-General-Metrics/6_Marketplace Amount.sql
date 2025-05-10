SELECT 
	FORMAT(ROUND(SUM(final_total), 0), 0) AS marketplace_amount
FROM 
	pos.transactions
WHERE vendor_id IN (2,3,5)
   AND type = 'sell'
   AND DATE(created_at) = '2025-05-08'