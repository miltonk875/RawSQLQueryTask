
-- Orders History By  Lats Seven Day's Orders

SELECT COUNT(*) AS total_orders
FROM transactions
WHERE business_id = 1
  AND location_id = 1
  AND created_by = 1
  AND type = 'sell'
  AND DATE(transaction_date) >= '2024-12-09'
  AND DATE(transaction_date) <= '2024-12-15';

-- Average Orders History For Lats Seven Day's Orders
WITH yesterday AS (
            SELECT 
                COUNT(*) AS total_average_orders
            FROM transactions
            WHERE business_id = 1
              AND location_id = 1
              AND created_by = 1
              AND type = 'sell'
			AND DATE(transaction_date) >= '2024-12-09'
			AND DATE(transaction_date) <= '2024-12-15'
        )
        SELECT 
            COALESCE(ROUND(total_average_orders / $days, 2), 0) AS all_average_orders
        FROM yesterday;
		

-- Get Percentage Change for Last Seven Day's Orders
WITH last_days AS (
    SELECT 
        COUNT(*) AS total_last
    FROM transactions
    WHERE business_id = 1
      AND location_id = 1
      AND created_by = 1
      AND type = 'sell'
      AND DATE(transaction_date) >= '2024-12-09'
      AND DATE(transaction_date) <= '2024-12-15'
),
previous_days AS (
    SELECT 
        COUNT(*) AS total_previous
    FROM transactions
    WHERE business_id = 1
      AND location_id = 1
      AND created_by = 1
      AND type = 'sell'
      AND DATE(transaction_date) >= '2024-12-02'
      AND DATE(transaction_date) <= '2024-12-08'
)
SELECT 
    COALESCE(
        ROUND(
            ((l.total_last - p.total_previous) / p.total_previous) * 100, 
            2
        ), 
        0
    ) AS comparisons_percentage
FROM last_days l, previous_days p;

