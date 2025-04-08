--------------------------------- Total Order Ampount ----------------------------
SELECT 
	 FORMAT(ROUND(COALESCE(SUM(o.grand_total), 0)), 2) AS total_order_amount
FROM 
	bbbd_ecommerce_test.orders o
WHERE 
	o.user_id=23880
    AND DATE(o.created_at)  BETWEEN '2025-03-16' AND '2025-03-16';
	
--------------------------------- Average Order Amount Comparisions----------------------------
SELECT 
    COALESCE(new.new_order_amount, 0) AS new_order_amount,
    COALESCE(old.old_order_amount, 0) AS old_order_amount,
    COALESCE(
        ROUND(
            ((COALESCE(new.new_order_amount, 0) - COALESCE(old.old_order_amount, 0)) / 
            NULLIF(COALESCE(old.old_order_amount, 0), 0)) * 100, 
            2
        ), 
        0
    ) AS order_comparision
FROM 
    (
        -- New period order
        SELECT 
            FORMAT(ROUND(COALESCE(SUM(o.grand_total), 0)), 2) AS new_order_amount
        FROM 
            bbbd_ecommerce_test.orders AS o
        WHERE 
            o.user_id = 23880
            AND DATE(o.created_at)  BETWEEN '2025-03-16' AND '2025-03-16'
    ) AS new,
    (
        -- Old period order
        SELECT 
            FORMAT(ROUND(COALESCE(SUM(o.grand_total), 0)), 2) AS old_order_amount
        FROM 
            bbbd_ecommerce_test.orders AS o
        WHERE 
            o.user_id = 23880
            AND DATE(o.created_at)  BETWEEN '2025-03-15' AND '2025-03-15'
    ) AS old;


