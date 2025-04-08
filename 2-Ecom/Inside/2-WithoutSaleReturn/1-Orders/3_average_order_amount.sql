/* Remarks: Results for Total Orders, Average Orders, Total Amount, Average Order Amount */
SELECT 

    FORMAT(ROUND(SUM(o.grand_total) / (DATEDIFF('2025-02-08', '2025-02-01') + 1)),0) AS total_average_order_amount

FROM 
    bbbd_ecommerce_test.orders AS o
WHERE 
    DATE(o.created_at) >= '2025-02-01'
    AND DATE(o.created_at) <= '2025-02-08'
	AND o.delivery_status='cancelled'; 
	
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
            ROUND(SUM(o.grand_total) / (DATEDIFF('2025-02-08', '2025-02-01') + 1)) AS new_avg_order_amount
        FROM 
            bbbd_ecommerce_test.orders AS o
        WHERE 
            DATE(o.created_at) >= '2025-02-01' AND DATE(o.created_at) <= '2025-02-08' AND o.delivery_status='cancelled'
    ) AS new,
    (
        -- Old period average
        SELECT 
            ROUND(SUM(o.grand_total) / (DATEDIFF('2025-01-31', '2025-01-24') + 1)) AS old_avg_order_amount
        FROM 
            bbbd_ecommerce_test.orders AS o
        WHERE 
            DATE(o.created_at) >= '2025-01-24' AND DATE(o.created_at) <= '2025-01-31' AND o.delivery_status='cancelled'
    ) AS old;
	