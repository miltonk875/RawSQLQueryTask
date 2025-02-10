/* Total Amount, Average Amount,Amount Comparisions */
SELECT 
      FORMAT(ROUND(SUM(od.quantity*od.price)),0) AS total_amount
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
	
/*
Remarks: Results for Total Order Amount Comparisions
PercentageChange = NewTotalOrderAmount- PreviousTotalOrderAmount/ PreviousTotalOrderAmout* 100
*/
SELECT 
    ROUND(
        ((COALESCE(new.new_order_amount, 0) - COALESCE(old.old_order_amount, 0)) / 
        NULLIF(COALESCE(old.old_order_amount, 0), 0)) * 100, 
        2
    ) AS percentage_change
FROM 
    (
        -- New period order
        SELECT 
            ROUND(SUM(od.quantity * od.price), 0) AS new_order_amount
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
            ROUND(SUM(od.quantity * od.price), 0) AS old_order_amount
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

