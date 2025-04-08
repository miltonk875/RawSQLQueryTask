SELECT 
    COUNT(DISTINCT CASE WHEN o.src = 'web' THEN o.id END) AS web_order,
	COUNT(DISTINCT CASE WHEN o.src = 'app' THEN o.id END) AS app_order
FROM 
    bbbd_ecommerce_test.orders AS o
WHERE 
o.user_id=23880
  AND DATE(o.created_at)  BETWEEN '2025-03-16' AND '2025-03-16';