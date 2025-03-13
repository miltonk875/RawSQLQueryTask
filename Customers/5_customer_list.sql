----------------------------------------------------- All Customers List------------------------------------
SELECT  
    ad.id AS customer_id,  
    MIN(ad.name) AS customer_name,  
    ad.phone,  
    ad.email,  
    DATE(ad.created_at) AS created_at,  
    COUNT(o.id) AS total_orders, 
	COUNT(w.id) AS total_wishlists 
FROM  
    bbbd_ecommerce_test.addresses ad  
LEFT JOIN  
    bbbd_ecommerce_test.orders o ON ad.id = o.user_id  
LEFT JOIN  
    bbbd_ecommerce_test.wishlists w ON ad.id = w.user_id
	
GROUP BY  
    ad.id, ad.email, ad.phone  
ORDER BY  
    created_at DESC;
	
	
	
	SELECT  
    ad.id AS customer_id,  
    MIN(ad.name) AS customer_name,  
    ad.phone,  
    ad.email,  
    DATE(ad.created_at) AS created_at,  
    COUNT(o.id) AS total_orders
FROM  
    bbbd_ecommerce_test.addresses ad  
LEFT JOIN  
    bbbd_ecommerce_test.orders o ON ad.id = o.user_id 
GROUP BY  
    ad.id, ad.email, ad.phone  
ORDER BY  
    created_at DESC;