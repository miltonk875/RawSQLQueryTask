SELECT  
	COUNT(DISTINCT o.user_id) as total_ecom_customers
FROM  
  bbbd_ecommerce_test.orders o
JOIN 
  bbbd_ecommerce_test.users u ON o.user_id = u.id
JOIN
	bbbd_ecommerce_test.addresses ad ON o.user_id=ad.id
WHERE 
	u.user_type='customer'