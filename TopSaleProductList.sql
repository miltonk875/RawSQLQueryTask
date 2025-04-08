SELECT 
    p.id as product_id, 
    p.name as product_name, 
    p.barcode,
    SUM(od.quantity) AS total_sale
FROM 
	bbbd_ecommerce_test.order_details od
JOIN 
	bbbd_ecommerce_test.products p ON od.product_id = p.id
WHERE 
	od.created_at >= DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y-%m-01')
AND 
	od.created_at <= LAST_DAY(NOW() - INTERVAL 1 MONTH)
GROUP BY 
	p.id
ORDER BY 
	total_sale DESC;