SELECT 
DATE(transaction_date) AS transaction_date,
DATE_FORMAT(transaction_date, '%l %p') AS transaction_time,
COUNT(*) AS total_order_count 
FROM transactions 
WHERE business_id = 1 
AND location_id = 1 
AND created_by = 1 
AND type = 'sell' 
AND DATE(transaction_date) >= '2024-12-22'
AND DATE(transaction_date) <= '2024-12-29'
GROUP BY DATE(transaction_date);