-------------------------------------- All From Web & App-------------------------------------
SELECT 
    COUNT(DISTINCT CASE WHEN o.src = 'web' THEN o.id END) AS web_order,
	COUNT(DISTINCT CASE WHEN o.src = 'app' THEN o.id END) AS app_order
FROM 
    bbbd_ecommerce_test.orders AS o;
	
	-------------------------------------- Date Wise From Web & App-------------------------------------
SELECT 
    COUNT(DISTINCT CASE WHEN o.src = 'web' THEN o.id END) AS web_order,
	COUNT(DISTINCT CASE WHEN o.src = 'app' THEN o.id END) AS app_order
FROM 
    bbbd_ecommerce_test.orders AS o;

 WHERE DATE(o.created_at) BETWEEN '2025-04-17' AND '2025-04-17'