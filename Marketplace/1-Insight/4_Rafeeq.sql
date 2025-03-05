--------------------------------- Total Orders ----------------------------
SELECT COUNT(*) AS total_orders
FROM pos.transactions as ts
WHERE ts.vendor_id=5
AND ts.type = 'sell'
AND DATE(ts.created_at) BETWEEN '2025-03-05' AND '2025-03-05';

--------------------------------- Total Order Amount ----------------------------
SELECT
	FORMAT(COALESCE(SUM(ts.final_total), 0), 0) AS total_order_amount
FROM pos.transactions as ts
WHERE ts.vendor_id=5
AND ts.type = 'sell'
AND DATE(ts.created_at) BETWEEN '2025-03-05' AND '2025-03-05';

--------------------------------- Average Order Comparisions----------------------------
SELECT 
	new.new_order as new_order,
	old.old_order as old_order,
    ROUND(
        ((new.new_order - old.old_order) / old.old_order) * 100, 
        2
    ) AS percentage_change
FROM 
    (
        -- New period order
        SELECT 
            COUNT(*) AS new_order
		FROM pos.transactions as ts
		WHERE ts.vendor_id=5
		AND ts.type = 'sell'
		AND DATE(ts.created_at) BETWEEN '2025-03-05' AND '2025-03-05'
    ) AS new,
    (
        -- Old period order
        SELECT 
            COUNT(*) AS old_order
		FROM pos.transactions as ts
		WHERE ts.vendor_id=5
		AND ts.type = 'sell'
		AND DATE(ts.created_at) BETWEEN '2025-03-04' AND '2025-03-04'
    ) AS old;