--SHow All Average Amount List
SELECT 
COALESCE(ROUND(SUM(final_total) / COUNT(*), 2), 0) 
AS total_average_order_amount 
FROM transactions 
WHERE business_id = 1 
AND location_id = 1 
AND created_by = 1 
AND type = 'sell' 
AND DATE(transaction_date) >= '2024-12-20'
AND DATE(transaction_date) <= '2024-12-23'
GROUP BY DATE(transaction_date);

--Get All Average Amount By One Column (USE THIS Query)

SELECT 
    COALESCE(ROUND(SUM(total_average_order_amount) / COUNT(*), 2), 0) AS overall_average_order_amount
FROM (
    SELECT 
        COALESCE(ROUND(SUM(final_total) / COUNT(*), 2), 0) AS total_average_order_amount
    FROM transactions 
    WHERE business_id = 1 
    AND location_id = 1 
    AND created_by = 1 
    AND type = 'sell' 
    AND DATE(transaction_date) >= '2024-12-20'
    AND DATE(transaction_date) <= '2024-12-23'
    GROUP BY DATE(transaction_date)
) AS daily_averages;
