
-- Orders History By Yesterday Date

SELECT 
    COUNT(*) AS total_yesterday_orders
FROM transactions
WHERE business_id = 1
  AND location_id = 1
  AND created_by = 1
  AND type = 'sell'
  AND transaction_date >= DATE_SUB('2024-12-14', INTERVAL 1 DAY) -- Start of yesterday
  AND transaction_date < '2024-12-14'; -- End of yesterday

-- Average Orders History For Yesterday Date
WITH yesterday AS (
    SELECT 
        COUNT(*) AS total_yesterday_orders
    FROM transactions
    WHERE business_id = 1
      AND location_id = 1
      AND created_by = 1
      AND type = 'sell'
      AND transaction_date >= DATE_SUB('2024-12-14', INTERVAL 1 DAY) -- Start of yesterday
      AND transaction_date < '2024-12-14' -- End of yesterday
)
SELECT 
    COALESCE(ROUND(total_yesterday_orders / 1, 2), 0) AS avg_orders_yesterday
FROM yesterday;

-- Get Percentage Change for Yesterday's Orders
SELECT 
    IFNULL(
        ROUND(
            (
                (SELECT COUNT(*) 
                 FROM transactions 
                 WHERE business_id = 1 
                   AND location_id = 1 
                   AND created_by = 1 
                   AND type = 'sell' 
                   AND DATE(transaction_date) = '2024-12-13') - 
                (SELECT COUNT(*) / 2 
                 FROM transactions 
                 WHERE business_id = 1 
                   AND location_id = 1 
                   AND created_by = 1 
                   AND type = 'sell' 
                   AND DATE(transaction_date) BETWEEN '2024-12-12' AND '2024-12-13')
            ) / 
            NULLIF(
                (SELECT COUNT(*) / 2 
                 FROM transactions 
                 WHERE business_id = 1 
                   AND location_id = 1 
                   AND created_by = 1 
                   AND type = 'sell' 
                   AND DATE(transaction_date) BETWEEN '2024-12-12' AND '2024-12-13'),
                0
            ) * 100, 
            2
        ), 
        0
    ) AS percentage_change;

