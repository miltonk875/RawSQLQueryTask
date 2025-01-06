SELECT 
	c.id AS category_id,
    c.name AS category_name,
    COUNT(p.id) AS total_products,
	SUM(CASE WHEN p.enable_stock =1 THEN 1 ELSE 0 END) AS active_products,
    SUM(CASE WHEN p.enable_stock =0 THEN 1 ELSE 0 END) AS inactive_products
FROM 
    categories c
LEFT JOIN 
    products p ON c.id = p.category_id
WHERE 
    c.business_id = 1 
GROUP BY 
    c.id, c.name
ORDER BY 
    total_products DESC
	
	
	-------ALter Query No zerro Count
	
SELECT 
	c.id AS category_id,
    c.name AS category_name,
    COUNT(p.id) AS total_products,
FROM 
    categories c
LEFT JOIN 
    products p ON c.id = p.category_id
WHERE 
    c.business_id = 1 
GROUP BY 
    c.id, c.name
HAVING 
    total_products > 0
ORDER BY 
    total_products DESC