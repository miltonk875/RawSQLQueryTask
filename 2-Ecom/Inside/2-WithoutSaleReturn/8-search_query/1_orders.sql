--------------------------------- Total Orders ----------------------------
SELECT 
    COUNT(od.quantity) AS orders
FROM 
    bbbd_ecommerce_test.order_details od
JOIN 
    bbbd_ecommerce_test.products p ON od.product_id = p.id
WHERE 
    DATE(od.created_at) >= '2025-02-09'
    AND DATE(od.created_at) <= '2025-02-09'
	--AND p.id=136
	--AND p.brand_id=14
	--AND p.category_id=255
	AND od.delivery_status='cancelled'
	
--------------------------------- Average Order----------------------------
SELECT 
	 ROUND(COUNT(od.quantity) / (DATEDIFF('2025-02-09', '2025-02-08') + 1)) AS average_order
FROM 
    bbbd_ecommerce_test.order_details od
JOIN 
    bbbd_ecommerce_test.products p ON od.product_id = p.id
WHERE 
    DATE(od.created_at) >= '2025-02-09' 
    AND DATE(od.created_at) <= '2025-02-09'
	--AND p.id=136
	--AND p.brand_id=14
	--AND p.category_id=255
	AND od.delivery_status='cancelled'
	
	
--------------------------------- Average Order Comparisions----------------------------
SELECT 
    ROUND(
        ((COALESCE(new.new_order, 0) - COALESCE(old.old_order, 0)) / 
        NULLIF(COALESCE(old.old_order, 0), 0)) * 100, 
        2
    ) AS percentage_change
FROM 
    (
        -- New period order
        SELECT 
            COALESCE(COUNT(od.quantity), 0) AS new_order
        FROM 
            bbbd_ecommerce_test.order_details AS od
        JOIN 
            bbbd_ecommerce_test.products p ON od.product_id = p.id
        WHERE 
            DATE(od.created_at) >= '2025-02-08' AND DATE(od.created_at) <= '2025-02-09'
		 --AND p.id=136
		 --AND p.brand_id=14
		 --AND p.category_id=255
		 AND od.delivery_status='cancelled'
    ) AS new,
    (
        -- Old period order
        SELECT 
            COALESCE(COUNT(od.quantity), 0) AS old_order
        FROM 
            bbbd_ecommerce_test.order_details AS od
        JOIN
            bbbd_ecommerce_test.products p ON od.product_id = p.id
        WHERE 
            DATE(od.created_at) >= '2025-02-06' AND DATE(od.created_at) <= '2025-02-07'
		 --AND p.id=136
		 --AND p.brand_id=14
		 --AND p.category_id=255
		 AND od.delivery_status='cancelled'
    ) AS old;
