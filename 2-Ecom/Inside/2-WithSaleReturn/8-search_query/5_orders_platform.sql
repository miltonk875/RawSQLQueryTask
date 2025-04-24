SELECT 
    COUNT(DISTINCT CASE WHEN o.src = 'web' THEN o.id END) AS web_order,
	COUNT(DISTINCT CASE WHEN o.src = 'app' THEN o.id END) AS app_order
FROM 
    bbbd_ecommerce_test.orders AS o
JOIN 
    bbbd_ecommerce_test.order_details od ON od.order_id = o.id
JOIN
    bbbd_ecommerce_test.products p ON od.product_id = p.id
WHERE 
    DATE(o.created_at) >= '2025-02-18'
    AND DATE(o.created_at) <= '2025-02-20'
	AND od.delivery_status='cancelled'
	-- AND p.id=136
    -- AND p.brand_id=14
    -- AND p.category_id=255

