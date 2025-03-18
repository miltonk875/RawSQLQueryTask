--------------------------------- Total Orders ----------------------------
SELECT 
	COUNT(*) as total_orders
FROM 
	bbbd_ecommerce_test.orders o
WHERE 
	o.user_id=23880
    AND DATE(o.created_at)  BETWEEN '2025-03-16' AND '2025-03-16';
	
--------------------------------- Average Order Comparisions----------------------------
SELECT 
    COALESCE(new.new_order, 0) AS new_order,
    COALESCE(old.old_order, 0) AS old_order,
    COALESCE(
        ROUND(
            ((COALESCE(new.new_order, 0) - COALESCE(old.old_order, 0)) / 
            NULLIF(COALESCE(old.old_order, 0), 0)) * 100, 
            2
        ), 
        0
    ) AS order_comparision
FROM 
    (
        -- New period order
        SELECT 
            COUNT(*) AS new_order
        FROM 
            bbbd_ecommerce_test.orders AS o
        WHERE 
            o.user_id = 23880
            AND DATE(o.created_at) = '2025-03-16'
    ) AS new,
    (
        -- Old period order
        SELECT 
            COUNT(*) AS old_order
        FROM 
            bbbd_ecommerce_test.orders AS o
        WHERE 
            o.user_id = 23880
            AND DATE(o.created_at) = '2025-03-15'
    ) AS old;



