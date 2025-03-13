----------------------------------------------------- All Customers List------------------------------------
SELECT  
    ad.id AS customer_id,  
    MIN(ad.name) AS customer_name,  
    ad.phone,  
    ad.email, 
    COALESCE(w.total_wishlists, 0) AS wishlists,
	COUNT(DISTINCT o.id) AS total_orders,  
	ROUND(COALESCE(SUM(od.quantity), 0)) AS total_quantity,
	FORMAT(ROUND(COALESCE(SUM(o.grand_total), 0)), 2) AS total_amount,
	DATE(ad.created_at) AS created_at
FROM  
    bbbd_ecommerce_test.addresses ad  
LEFT JOIN  
    bbbd_ecommerce_test.orders o ON ad.id = o.user_id  
LEFT JOIN  
    bbbd_ecommerce_test.order_details od ON o.id = od.order_id  
LEFT JOIN  
    (SELECT user_id, COUNT(*) AS total_wishlists 
     FROM bbbd_ecommerce_test.wishlists 
     GROUP BY user_id) w ON ad.id = w.user_id  
GROUP BY  
    ad.id  
ORDER BY  
    total_orders DESC
LIMIT 10;
	
----------------------------------------------------- Customers List By Date Wise------------------------------------
	
SELECT  
    ad.id AS customer_id,  
    MIN(ad.name) AS customer_name,  
    ad.phone,  
    ad.email, 
    COALESCE(w.total_wishlists, 0) AS wishlists,
	COUNT(DISTINCT o.id) AS total_orders,  
	ROUND(COALESCE(SUM(od.quantity), 0)) AS total_quantity,
	FORMAT(ROUND(COALESCE(SUM(o.grand_total), 0)), 2) AS total_amount,
	DATE(ad.created_at) AS created_at
FROM  
    bbbd_ecommerce_test.addresses ad  
LEFT JOIN  
    bbbd_ecommerce_test.orders o ON ad.id = o.user_id  
LEFT JOIN  
    bbbd_ecommerce_test.order_details od ON o.id = od.order_id  
LEFT JOIN  
    (SELECT user_id, COUNT(*) AS total_wishlists 
     FROM bbbd_ecommerce_test.wishlists 
     GROUP BY user_id) w ON ad.id = w.user_id  
 WHERE DATE(ad.created_at) BETWEEN '2025-03-013' AND '2025-03-13'
GROUP BY  
    ad.id  
ORDER BY  
    total_orders DESC
LIMIT 10;