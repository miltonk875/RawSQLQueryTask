--------------------------------- Total Orders ----------------------------
SELECT 
	COUNT(*) AS total_orders
FROM pos.pos_orders as po
WHERE po.vendor_id=3
AND po.order_type = 'sell'
AND po.brand_id=14
--AND po.category_id=255
AND DATE(po.created_date) BETWEEN '2025-03-09' AND '2025-03-09';

--------------------------------- Total Order Amount ----------------------------
SELECT 
	FORMAT(COALESCE(SUM(DISTINCT po.grand_total), 0), 0) AS total_order_amount
FROM pos.pos_orders as po
WHERE po.vendor_id=3
AND po.order_type = 'sell'
AND po.brand_id=14
--AND po.category_id=255
AND DATE(po.created_date) BETWEEN '2025-03-09' AND '2025-03-09';


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
		FROM pos.pos_orders as po
		WHERE po.vendor_id=3
		AND po.order_type = 'sell'
		AND po.brand_id=14
		--AND po.category_id=255
		AND DATE(po.created_date) BETWEEN '2025-03-09' AND '2025-03-09'
    ) AS new,
    (
        -- Old period order
		SELECT 
			COUNT(*) AS old_order
		FROM pos.pos_orders as po
		WHERE po.vendor_id=3
		AND po.order_type = 'sell'
		AND po.brand_id=14
		--AND po.category_id=255
		AND DATE(po.created_date) BETWEEN '2025-03-08' AND '2025-03-08'
    ) AS old;