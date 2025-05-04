----------------------------------------------------------- Product Wise Order -------------------------------------------------
SELECT 
    p.id,
    p.name,
    p.unit_price,
    SUM(od.quantity) AS sale_quantity,
    SUM(od.quantity * od.price) AS total_sale_amount,
    GROUP_CONCAT(DISTINCT od.order_id ORDER BY od.order_id) AS order_ids,
    COUNT(DISTINCT od.order_id) AS total_orders
FROM 
	bbbd_ecommerce_test.products AS p
INNER JOIN 
	bbbd_ecommerce_test.order_details AS od ON p.id = od.product_id
WHERE 
	DATE(od.created_at) >='2025-05-04' AND DATE(od.created_at) <= '2025-05-04'
GROUP BY 
	p.id, p.name, p.unit_price
ORDER BY 
	sale_quantity DESC;
	
----------------------------------------------------------- Brand Wise Order -------------------------------------------------
SELECT 
    br.id,
    br.name,
    SUM(od.quantity) AS sale_quantity,
    SUM(od.quantity * od.price) AS total_sale_amount,
    GROUP_CONCAT(DISTINCT od.order_id ORDER BY od.order_id) AS order_ids,
    COUNT(DISTINCT od.order_id) AS total_orders
FROM 
	bbbd_ecommerce_test.products AS p
LEFT JOIN
	bbbd_ecommerce_test.brands AS br ON p.brand_id = br.id
INNER JOIN 
	bbbd_ecommerce_test.order_details AS od ON p.id = od.product_id
WHERE 
	DATE(od.created_at) >='2025-05-04' AND DATE(od.created_at) <= '2025-05-04'
GROUP BY 
	p.brand_id, br.name
ORDER BY 
	sale_quantity DESC;
----------------------------------------------------------- Category Wise Order -------------------------------------------------
SELECT 
    ca.id,
    ca.name,
    SUM(od.quantity) AS sale_quantity,
    SUM(od.quantity * od.price) AS total_sale_amount,
    GROUP_CONCAT(DISTINCT od.order_id ORDER BY od.order_id) AS order_ids,
    COUNT(DISTINCT od.order_id) AS total_orders
FROM 
	bbbd_ecommerce_test.products AS p
LEFT JOIN
	bbbd_ecommerce_test.categories AS ca ON p.category_id = ca.id
INNER JOIN 
	bbbd_ecommerce_test.order_details AS od ON p.id = od.product_id
WHERE 
	DATE(od.created_at) >='2025-05-04' AND DATE(od.created_at) <= '2025-05-04'
GROUP BY 
	p.category_id, ca.name
ORDER BY 
	sale_quantity DESC;