
	---------------------------------------- Date Wise Web & App Order ----------------------------------------
SELECT 
    COUNT(DISTINCT CASE WHEN o.src = 'web' THEN od.order_id END) AS web_order_count,
    COUNT(DISTINCT CASE WHEN o.src = 'app' THEN od.order_id END) AS app_order_count
FROM 
    order_details AS od
JOIN 
    orders AS o ON o.id = od.order_id
JOIN 
	products p ON od.product_id = p.id
	
WHERE 
    DATE(od.created_at) >= '2025-01-10'
    AND DATE(od.created_at) <= '2025-01-10';
	
---------------------------------------- Date Wise Web & App Order with Brand ----------------------------------------
SELECT 
    COUNT(DISTINCT CASE WHEN o.src = 'web' THEN od.order_id END) AS web_order_count,
    COUNT(DISTINCT CASE WHEN o.src = 'app' THEN od.order_id END) AS app_order_count
FROM 
    order_details AS od
JOIN 
    orders AS o ON o.id = od.order_id
JOIN 
	products p ON od.product_id = p.id

WHERE 
	p.brand_id=14
    AND DATE(od.created_at) >= '2025-01-10'
    AND DATE(od.created_at) <= '2025-01-10';
	
---------------------------------------- Date Wise Web & App Order with Category ----------------------------------------
		
SELECT 
    COUNT(DISTINCT CASE WHEN o.src = 'web' THEN od.order_id END) AS web_order_count,
    COUNT(DISTINCT CASE WHEN o.src = 'app' THEN od.order_id END) AS app_order_count
FROM 
    order_details AS od
JOIN 
    orders AS o ON o.id = od.order_id
JOIN 
	products p ON od.product_id = p.id

WHERE 
	p.category_id=255
    AND DATE(od.created_at) >= '2025-01-10'
    AND DATE(od.created_at) <= '2025-01-10';
	
	
	
