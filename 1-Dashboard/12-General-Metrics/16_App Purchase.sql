SELECT 
	COUNT(DISTINCT CASE WHEN o.src = 'app' THEN o.id END) AS app_purchase
FROM 
    bbbd_ecommerce_test.orders AS o;
 -------------------------------------- Date Wise From App-------------------------------------
SELECT 
	COUNT(DISTINCT CASE WHEN o.src = 'app' THEN o.id END) AS app_purchase
FROM 
    bbbd_ecommerce_test.orders AS o
    
 WHERE DATE(o.created_at) BETWEEN '2025-04-17' AND '2025-04-17'