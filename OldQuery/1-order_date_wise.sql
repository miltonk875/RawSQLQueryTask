SELECT COUNT(*) AS total_orders
FROM transactions
WHERE business_id = 1
  AND location_id = 1
  AND created_by = 1
  AND type = 'sell'
  AND DATE(transaction_date) >= '2024-12-21'
  AND DATE(transaction_date) <= '2024-12-22';