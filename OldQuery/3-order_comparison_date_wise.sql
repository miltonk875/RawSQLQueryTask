--Order Count Comparisons
WITH last_days AS (
    SELECT 
        COUNT(*) AS total_last_count
    FROM transactions
    WHERE business_id = 1
      AND location_id = 1
      AND created_by = 1
      AND type = 'sell'
      AND DATE(transaction_date) >='2024-12-21' AND DATE(transaction_date) <= '2024-12-22'
),
previous_days AS (
    SELECT 
        COUNT(DISTINCT id) AS total_previous_count
    FROM transactions
    WHERE business_id = 1
      AND location_id = 1
      AND created_by = 1
      AND type = 'sell'
      AND DATE(transaction_date) >='2024-12-19' AND DATE(transaction_date) <= '2024-12-20'
)
SELECT 
    COALESCE(
        ROUND(
            ((last_days.total_last_count - previous_days.total_previous_count) / 
             previous_days.total_previous_count) * 100, 
            2
        ), 
        0
    ) AS comparisons_percentage
FROM last_days, previous_days;