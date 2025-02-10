SELECT 
    c.name as category_name, 
    COUNT(od.product_id) AS total_order
FROM 
    bbbd_ecommerce_test.categories c
JOIN 
    bbbd_ecommerce_test.products p ON p.category_id = c.id
JOIN 
    bbbd_ecommerce_test.order_details od ON od.product_id = p.id
WHERE 
    DATE(od.created_at) >= '2025-02-01'
    AND DATE(od.created_at) <= '2025-02-08'
GROUP BY 
    c.name 
ORDER BY 
    total_order DESC;