/* Remarks: Results for Total Orders, Average Orders, Total Amount, Average Order Amount */
SELECT 
    -- Total Order Count
    COUNT(o.id) AS total_order, 

    -- Average Order Count Per Day
    ROUND(COUNT(o.id) / (DATEDIFF('2025-02-08', '2025-02-01') + 1)) AS average_order, 

    -- Total Order Amount for Current Period
    FORMAT(ROUND(SUM(grand_total)),0) AS total_order_amount, 
	
    -- Previous Period's Total Order Amount
    (SELECT FORMAT(ROUND(SUM(grand_total)),0) 
     FROM bbbd_ecommerce_test.orders AS o
     WHERE DATE(o.created_at) >= '2025-02-07' AND DATE(o.created_at) <= '2025-02-08') AS previous_total_order_amount,
	 
    -- Average Order Amount Per Day
    FORMAT(ROUND(SUM(o.grand_total) / (DATEDIFF('2025-02-08', '2025-02-01') + 1)),0) AS total_average_order_amount
	 
FROM 
    bbbd_ecommerce_test.orders AS o
WHERE 
    DATE(o.created_at) >= '2025-02-01' /* From Date */
    AND DATE(o.created_at) <= '2025-02-08'; /* To Date */
	
/****
Results: 
total_order		average_order		total_order_amount 		previous_total_order_amount 	total_average_order_amount

	179				22						38228					5749								4779
	
****/

/*
Remarks: Results for Total Order Comparisions
PercentageChange = NewTotalOrder- PreviousTotalOrder/ PreviousTotalOrder* 100
*/
SELECT 
    new.new_order,
    old.old_order,
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
	
/****
Results: 
total_order		previous_order		order_comparisons_percentage

	179				190						-5.79	
	
****/
	
/*
Remarks: Results for Total Order Amount Comparisions
PercentageChange = NewTotalOrderAmount- PreviousTotalOrderAmount/ PreviousTotalOrderAmout* 100
*/
SELECT 
    new.new_order_amount,
    old.old_order_amount,
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
	
/****
Results: 
new_order_amount		old_order_amount		order_amount_percentage
		38503				39888						-3.47
	
****/
/*
Remarks: Results for Total Avarage Order Amount Comparisions
PercentageChange = NewTotalAvgOrderAmount- PreviousTotalAvgOrderAmount/ PreviousTotalAvgOrderAmout* 100
*/
SELECT 
    new.new_avg_order_amount,
    old.old_avg_order_amount,
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
            DATE(o.created_at) >= '2025-02-01' AND DATE(o.created_at) <= '2025-02-08'
    ) AS new,
    (
        -- Old period average
        SELECT 
            ROUND(SUM(o.grand_total) / (DATEDIFF('2025-01-31', '2025-01-24') + 1)) AS old_avg_order_amount
        FROM 
            bbbd_ecommerce_test.orders AS o
        WHERE 
            DATE(o.created_at) >= '2025-01-24' AND DATE(o.created_at) <= '2025-01-31'
    ) AS old;
	
/****
Results: 
new_avg_order_amount	old_avg_order_amount	avg_order_amount_percentage

	4813					4986					-3.47
	
****/

/*
Remarks: Results for Total Order & Amount From Web & App
PercentageChange = NewTotalAvgOrderAmount- PreviousTotalAvgOrderAmount/ PreviousTotalAvgOrderAmout* 100
*/

SELECT 
    COUNT(DISTINCT CASE WHEN o.src = 'web' THEN o.id END) AS web_order,
    FORMAT(ROUND(SUM(CASE WHEN o.src = 'web' THEN o.grand_total ELSE 0 END)), 0) AS web_order_amount,
	COUNT(DISTINCT CASE WHEN o.src = 'app' THEN o.id END) AS app_order,
    FORMAT(ROUND(SUM(CASE WHEN o.src = 'app' THEN o.grand_total ELSE 0 END)), 0) AS app_order_amount
FROM 
    bbbd_ecommerce_test.orders AS o
WHERE 
    DATE(o.created_at) >= '2025-02-01'
    AND DATE(o.created_at) <= '2025-02-08';
	
/****
Results: 
web_order	web_order_amount	app_order 	app_order_amount

   174			37,595				6			838
	
****/