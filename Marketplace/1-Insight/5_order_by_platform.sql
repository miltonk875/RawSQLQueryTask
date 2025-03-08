SELECT  
  v.id as vendor_id,
  v.name as vendor_name,
  COUNT(*) AS total_orders,
  ROUND(
    (COUNT(*) / 
      (SELECT COUNT(*) 
       FROM pos.transactions 
       WHERE vendor_id IN (2,3,5) 
       AND type = 'sell'
       AND DATE(created_at) BETWEEN '2025-03-05' AND '2025-03-05')
    ) * 100, 2
  ) AS order_percentage
FROM 
	pos.transactions AS ts
JOIN 
	vendors AS v ON ts.vendor_id = v.id
WHERE 
	ts.vendor_id IN (2,3,5)
	AND ts.type = 'sell'
	AND DATE(ts.created_at) BETWEEN '2025-03-05' AND '2025-03-05'
GROUP BY 
	ts.vendor_id;