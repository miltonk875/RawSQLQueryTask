--SHow All Average Amount List
SELECT 
COALESCE(ROUND(SUM(final_total) / COUNT(*), 2), 0) 
AS total_average_order_amount 
FROM transactions 
WHERE business_id = 1 
AND location_id = 1 
AND created_by = 1 
AND type = 'sell' 
AND DATE(transaction_date) >= '2024-12-21' 
AND DATE(transaction_date) <= '2024-12-25' 
GROUP BY DATE(transaction_date);


--Get All Average Amount By One Column
SELECT 
COALESCE(ROUND(SUM(daily_avg) / COUNT(daily_avg), 2), 0) AS total_average_order_amount
FROM (
SELECT 
DATE(transaction_date) AS transaction_date,
SUM(final_total) / COUNT(*) AS daily_avg
FROM transactions
WHERE business_id = 1
AND location_id = 1
AND created_by = 1
AND type = 'sell'
AND DATE(transaction_date) >= '2024-12-21'
AND DATE(transaction_date) <= '2024-12-25'
GROUP BY DATE(transaction_date)
) AS daily_averages;