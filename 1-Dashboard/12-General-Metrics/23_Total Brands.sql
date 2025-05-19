SELECT 
    COALESCE(COUNT(b.id), 0) AS total_brand
FROM 
	bbbd_ecommerce_test.brands b
