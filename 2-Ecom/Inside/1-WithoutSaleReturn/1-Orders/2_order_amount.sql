/* Total Amount, Average Amount,Amount Comparisions */
SELECT 
    FORMAT(ROUND(SUM(grand_total)),0) AS total_amount
FROM 
    bbbd_ecommerce_test.orders AS o
WHERE 
    DATE(o.created_at) >= '2025-02-01'
    AND DATE(o.created_at) <= '2025-02-08';
	
/*
Remarks: Results for Total Order Amount Comparisions
PercentageChange = NewTotalOrderAmount- PreviousTotalOrderAmount/ PreviousTotalOrderAmout* 100
*/
SELECT 
    ROUND(
        ((new.new_order_amount - old.old_order_amount) / old.old_order_amount) * 100, 
        2
    ) AS order_amount_percentage
FROM 
    (
        -- New period average
        SELECT 
            ROUND(SUM(o.grand_total)) AS new_order_amount
        FROM 
            bbbd_ecommerce_test.orders AS o
        WHERE 
            DATE(o.created_at) >= '2025-02-01' AND DATE(o.created_at) <= '2025-02-08'
    ) AS new,
    (
        -- Old period average
        SELECT 
            ROUND(SUM(o.grand_total)) AS old_order_amount
        FROM 
            bbbd_ecommerce_test.orders AS o
        WHERE 
            DATE(o.created_at) >= '2025-01-24' AND DATE(o.created_at) <= '2025-01-31'
    ) AS old;
