WITH last_days AS (
    SELECT 
        COUNT(*) AS total_last_count
    FROM order_details
    WHERE DATE(created_at) >='2025-01-12' AND DATE(created_at) <= '2025-01-13'
),
previous_days AS (
    SELECT 
        COUNT(*) AS total_previous_count
    FROM order_details
    WHERE DATE(created_at) >='2025-01-10' AND DATE(created_at) <= '2025-01-11'
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