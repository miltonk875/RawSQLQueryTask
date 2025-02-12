SELECT 
    COUNT(DISTINCT CASE WHEN o.src = 'web' THEN o.id END) AS web_order,
	COUNT(DISTINCT CASE WHEN o.src = 'app' THEN o.id END) AS app_order
FROM 
    bbbd_ecommerce_test.orders AS o
JOIN 
    bbbd_ecommerce_test.order_details od ON od.order_id = o.id
WHERE 
    DATE(o.created_at) >= '2025-02-12'
    AND DATE(o.created_at) <= '2025-02-12'
    AND od.product_id='5608'