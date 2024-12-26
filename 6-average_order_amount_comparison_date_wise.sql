-- Percentage Change Formula: ((Avg1 - Avg2) / Avg2) * 100
SELECT 
    COALESCE(
        ROUND(
            ((overall_average_order_amount - overall_average_order_amount2) / overall_average_order_amount2) * 100, 
        2), 
    0) AS percentage_change
FROM (

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
) AS daily_averages

) AS avg1,
(
SELECT 
    COALESCE(ROUND(SUM(total_average_order_amount2) / COUNT(*), 2), 0) AS overall_average_order_amount2
FROM (
    SELECT 
        COALESCE(ROUND(SUM(final_total) / COUNT(*), 2), 0) AS total_average_order_amount2
    FROM transactions 
    WHERE business_id = 1 
    AND location_id = 1 
    AND created_by = 1 
    AND type = 'sell' 
    AND DATE(transaction_date) >= '2024-12-16'
    AND DATE(transaction_date) <= '2024-12-19'
    GROUP BY DATE(transaction_date)
) AS daily_averages2
	
) AS avg2;
