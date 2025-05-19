------------------------------------------------------------- Echom Order Chart List -----------------------------------------------------------
SELECT 
    COUNT(*) AS total_ecom_order,
    DATE(o.created_at) AS ecom_order_date
FROM 
    bbbd_ecommerce_test.orders o
WHERE 
    DATE(o.created_at) >= '2025-02-01' 
    AND DATE(o.created_at) <= '2025-02-08'
GROUP BY 
    DATE(o.created_at)
	
------------------------------------------------------------- Marcket Place Order Chart List -----------------------------------------------------------
SELECT  
  COUNT(*) AS total_market_orders,
  DATE(ts.created_at) AS market_order_date
FROM 
  pos.transactions AS ts
JOIN 
  pos.vendors AS v ON ts.vendor_id = v.id
WHERE 
  ts.vendor_id IN (2,3,5)
  AND ts.type = 'sell'
    AND DATE(ts.created_at) >= '2025-02-01' 
    AND DATE(ts.created_at) <= '2025-02-08'
GROUP BY 
  v.id,market_order_date;