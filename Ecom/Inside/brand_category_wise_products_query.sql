---------------------------------Brand Wise Products-------------------------

SELECT 
	b.id AS brand_id,
    b.name AS brand_name,
    COUNT(p.id) AS total_products
FROM 
    bbbd_ecommerce_test.brands b
LEFT JOIN 
    bbbd_ecommerce_test.products p ON b.id = p.brand_id
	
GROUP BY 
    b.id, b.name
HAVING 
    total_products > 0
ORDER BY 
    total_products DESC; 

---------------------------------Category Wise Products-------------------------
SELECT 
	c.id AS category_id,
    c.name AS category_name,
    COUNT(p.id) AS total_products
FROM 
    bbbd_ecommerce_test.categories c
LEFT JOIN 
    bbbd_ecommerce_test.products p ON c.id = p.category_id
GROUP BY 
    c.id, c.name
HAVING 
    total_products > 0
ORDER BY 
    total_products DESC
	