	SELECT 
	b.id AS brand_id,
    b.name AS brand_name,
    COUNT(p.id) AS total_products,
    SUM(CASE WHEN p.enable_stock =1 THEN 1 ELSE 0 END) AS active_products,
    SUM(CASE WHEN p.enable_stock =0 THEN 1 ELSE 0 END) AS inactive_products
FROM 
    brands b
LEFT JOIN 
    products p ON b.id = p.brand_id
WHERE 
    b.business_id = 1 
GROUP BY 
    b.id, b.name
ORDER BY 
    total_products DESC;