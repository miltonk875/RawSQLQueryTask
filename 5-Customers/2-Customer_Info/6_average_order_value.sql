--------------------------------- Average Order Value ----------------------------
SELECT 
    FORMAT(ROUND(SUM(od.quantity*od.price) / COUNT(*), 0), 0) AS average_order_value
FROM 
	bbbd_ecommerce_test.orders o
JOIN  
  bbbd_ecommerce_test.order_details od ON od.order_id = o.id
WHERE 
	o.user_id=23880
    AND DATE(od.created_at)  BETWEEN '2025-03-16' AND '2025-03-16';
	
--------------------------------- Average Order Value Comparisions----------------------------
SELECT 
    COALESCE(new.new_order_value, 0) AS new_order_value,
    COALESCE(old.old_order_value, 0) AS old_order_value,
    COALESCE(
        ROUND(
            ((COALESCE(new.new_order_value, 0) - COALESCE(old.old_order_value, 0)) / 
            NULLIF(COALESCE(old.old_order_value, 0), 0)) * 100, 
            2
        ), 
        0
    ) AS order_comparision
FROM 
    (
        -- New period order
        SELECT 
            FORMAT(ROUND(SUM(od.quantity*od.price) / COUNT(*), 0), 0) AS new_order_value
        FROM 
            bbbd_ecommerce_test.orders AS o
		JOIN  
			bbbd_ecommerce_test.order_details od ON od.order_id = o.id
        WHERE 
            o.user_id = 23880
            AND DATE(od.created_at)  BETWEEN '2025-03-16' AND '2025-03-16'
    ) AS new,
    (
        -- Old period order
        SELECT 
            FORMAT(ROUND(SUM(od.quantity*od.price) / COUNT(*), 0), 0) AS old_order_value
        FROM 
            bbbd_ecommerce_test.orders AS o
		JOIN  
			bbbd_ecommerce_test.order_details od ON od.order_id = o.id
        WHERE 
            o.user_id = 23880
            AND DATE(od.created_at)  BETWEEN '2025-03-15' AND '2025-03-15'
    ) AS old;


