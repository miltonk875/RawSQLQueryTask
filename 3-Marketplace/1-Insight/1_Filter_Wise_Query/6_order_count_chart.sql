SELECT  
  v.id AS vendor_id,
  v.name AS vendor_name,
  COUNT(*) AS total_orders,
  DATE(po.created_date) AS order_date
FROM 
  pos.pos_orders AS po
JOIN 
  vendors AS v ON po.vendor_id = v.id
WHERE  
    po.vendor_id IN (2,3,5)  
    AND po.order_type = 'sell'  
    AND po.brand_id = 14  
    AND DATE(po.created_date) BETWEEN '2025-03-01' AND '2025-03-09' 
GROUP BY 
  v.id, v.name, order_date;