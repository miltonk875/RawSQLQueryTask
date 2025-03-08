	
------------------------------ Date Wise Order Count like current 7 days-------------------------------

SELECT  
  v.id AS vendor_id,
  v.name AS vendor_name,
  COUNT(*) AS total_orders,
  DATE(ts.created_at) AS order_date
FROM 
  pos.transactions AS ts
JOIN 
  vendors AS v ON ts.vendor_id = v.id
WHERE 
  ts.vendor_id IN (2,3,5)
  AND ts.type = 'sell'
  AND DATE(ts.created_at) BETWEEN '2025-03-01' AND '2025-03-07'
GROUP BY 
  v.id, v.name, order_date;