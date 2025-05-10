SELECT 
    COUNT(o.id) AS ecom_order
FROM 
    bbbd_ecommerce_test.orders AS o
	
WHERE 
	DATE(created_at) = '2025-05-08'