/* Remarks: Results for Total Orders, Average Orders, Total Amount, Average Order Amount */
SELECT 
    FORMAT(
        ROUND(
            COALESCE(SUM(od.quantity * od.price), 0) / (DATEDIFF('2025-02-08', '2025-02-01') + 1),
            0
        ), 
        0
    ) AS average_order_amount
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

	
	
/*
Remarks: Results for Total Avarage Order Amount Comparisions
PercentageChange = NewTotalAvgOrderAmount- PreviousTotalAvgOrderAmount/ PreviousTotalAvgOrderAmout* 100
*/
SELECT 
    ROUND(
        ((new.new_avg_order_amount - old.old_avg_order_amount) / old.old_avg_order_amount) * 100, 
        2
    ) AS avg_order_amount_percentage
FROM 
    (
        -- New period average
        SELECT 
            ROUND(SUM(od.quantity * od.price) / (DATEDIFF('2025-02-09', '2025-02-08') + 1)) AS new_avg_order_amount
		FROM 
			bbbd_ecommerce_test.order_details od
		JOIN 
			bbbd_ecommerce_test.products p ON od.product_id = p.id
        WHERE 
            DATE(od.created_at) >= '2025-02-08' AND DATE(od.created_at) <= '2025-02-09'
			--AND p.id=136
			--AND p.brand_id=14
			--AND p.category_id=255

    ) AS new,
    (
        -- Old period average
        SELECT 
            ROUND(SUM(od.quantity * od.price) / (DATEDIFF('2025-02-07', '2025-02-06') + 1)) AS old_avg_order_amount
		FROM 
			bbbd_ecommerce_test.order_details od
		JOIN 
			bbbd_ecommerce_test.products p ON od.product_id = p.id
        WHERE 
            DATE(od.created_at) >= '2025-02-06' AND DATE(od.created_at) <= '2025-02-07'
		--AND p.id=136
		--AND p.brand_id=14
		--AND p.category_id=255

    ) AS old;
	