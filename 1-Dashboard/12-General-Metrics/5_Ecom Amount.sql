SELECT 
	FORMAT(ROUND(SUM(grand_total), 0), 0) AS ecom_amount
FROM 
	bbbd_ecommerce_test.orders
WHERE 
	DATE(created_at) = '2025-05-08'