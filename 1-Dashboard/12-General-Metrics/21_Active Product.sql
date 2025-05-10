SELECT 
    COALESCE(COUNT(p.id), 0) AS active_product
FROM 
	bbbd_ecommerce_test.products p
WHERE 
	published=1

