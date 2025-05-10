SELECT 
	FORMAT(ROUND(SUM(tsl.quantity) / (DATEDIFF('2025-05-10', '2025-05-10') + 1)),0) AS market_average_order_quanity
FROM 
    pos.transaction_sell_lines tsl
JOIN 
    pos.transactions ts ON tsl.transaction_id = ts.id
WHERE 
    ts.vendor_id IN (2,3,5)
AND ts.type = 'sell'
AND DATE(tsl.created_at) >= '2025-05-10'
AND DATE(tsl.created_at) <= '2025-05-10'; 
