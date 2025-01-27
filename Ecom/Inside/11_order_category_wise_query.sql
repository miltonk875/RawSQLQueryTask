SELECT 
    c.name AS category_name,
    COUNT(od.product_id) AS total_sold
FROM 
    order_details od
JOIN 
    product_categories pc ON od.product_id = pc.product_id
JOIN 
    categories c ON pc.category_id = c.id
WHERE 
    DATE(od.created_at) >= '${today}' 
    AND DATE(od.created_at) <= '${today}'
GROUP BY 
    c.id, c.name
ORDER BY 
    total_sold DESC

------------------------------ Search Wise --------------------------------

SELECT 
    c.name AS category_name,
    COUNT(od.product_id) AS total_sold
FROM 
    order_details od
JOIN 
	products p ON od.product_id = p.id
JOIN 
    categories c ON p.category_id = c.id
WHERE 
	-- p.id = 136
	-- p.category_id = 255
	-- p.brand_id = 14
 AND DATE(od.created_at) >= '${today}' 
 AND DATE(od.created_at) <= '${today}'
 
GROUP BY 
    c.id, c.name
ORDER BY 
    total_sold DESC;