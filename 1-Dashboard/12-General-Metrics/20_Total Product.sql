SELECT 
    COALESCE(COUNT(p.id), 0) AS total_product
FROM 
	bbbd_ecommerce_test.products p
