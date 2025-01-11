SELECT SUM(final_total) AS total_order_amount
FROM transactions
WHERE business_id = 1
AND location_id = 1
AND created_by = 1
AND type = 'sell'
AND DATE(transaction_date) >= '2024-12-22'
AND DATE(transaction_date) <= '2024-12-23'