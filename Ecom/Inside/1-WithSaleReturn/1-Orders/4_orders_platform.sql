SELECT 
    COUNT(DISTINCT CASE WHEN o.src = 'web' THEN o.id END) AS web_order,
	COUNT(DISTINCT CASE WHEN o.src = 'app' THEN o.id END) AS app_order
FROM 
    bbbd_ecommerce_test.orders AS o
WHERE 
    DATE(o.created_at) >= '2025-02-028'
    AND DATE(o.created_at) <= '2025-02-08';
	