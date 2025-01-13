WITH last_days AS (
    SELECT 
        ROUND(SUM(quantity * price)) AS total_last_amount
    FROM order_details
    WHERE DATE(created_at) >='2025-01-12' AND DATE(created_at) <= '2025-01-13'
),
previous_days AS (
    SELECT 
        ROUND(SUM(quantity * price)) AS total_previous_amount
    FROM order_details
    WHERE DATE(created_at) >='2025-01-10' AND DATE(created_at) <= '2025-01-11'
)
SELECT 
    COALESCE(
        ROUND(
            ((last_days.total_last_amount - previous_days.total_previous_amount) / 
             previous_days.total_previous_amount) * 100, 
            2
        ), 
        0
    ) AS comparisons_percentage
FROM last_days, previous_days;

------------------------------------------ Brand Wise Order comparisons-----------------------------------------
WITH last_days AS (
    SELECT 
        ROUND(SUM(quantity * price)) AS total_last_amount
    FROM order_details od
    JOIN products p ON od.product_id = p.id
    WHERE DATE(od.created_at) BETWEEN '2025-01-12' AND '2025-01-13'
      AND p.brand_id = 14
),
previous_days AS (
    SELECT 
        ROUND(SUM(quantity * price)) AS total_previous_amount
    FROM order_details od
    JOIN products p ON od.product_id = p.id
    WHERE DATE(od.created_at) BETWEEN '2025-01-10' AND '2025-01-11'
      AND p.brand_id = 14
)
SELECT 
    COALESCE(
        ROUND(
            ((last_days.total_last_amount - previous_days.total_previous_amount) * 100.0 / 
             NULLIF(previous_days.total_previous_amount, 0)), 
            2
        ), 
        0
    ) AS comparison_percentage
FROM last_days, previous_days;
