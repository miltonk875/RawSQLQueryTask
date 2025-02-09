--------------------------------- Total Orders ----------------------------
SELECT 
    COUNT(o.id) AS total_order
FROM 
    bbbd_ecommerce_test.orders AS o
WHERE 
    DATE(o.created_at) >= '2025-02-01'
    AND DATE(o.created_at) <= '2025-02-08';
	
--------------------------------- Average Order----------------------------
SELECT 
    ROUND(COUNT(o.id) / (DATEDIFF('2025-02-08', '2025-02-01') + 1)) AS average_order
FROM 
    bbbd_ecommerce_test.orders AS o
WHERE 
    DATE(o.created_at) >= '2025-02-01'
    AND DATE(o.created_at) <= '2025-02-08';
	
--------------------------------- Average Order Comparisions----------------------------
SELECT 
    ROUND(
        ((new.new_order - old.old_order) / old.old_order) * 100, 
        2
    ) AS percentage_change
FROM 
    (
        -- New period order
        SELECT 
            COUNT(*) AS new_order
        FROM 
            bbbd_ecommerce_test.orders AS o
        WHERE 
            DATE(o.created_at) >= '2025-02-01' AND DATE(o.created_at) <= '2025-02-08'
    ) AS new,
    (
        -- Old period order
        SELECT 
            COUNT(*) AS old_order
        FROM 
            bbbd_ecommerce_test.orders AS o
        WHERE 
            DATE(o.created_at) >= '2025-01-24' AND DATE(o.created_at) <= '2025-01-31'
    ) AS old;