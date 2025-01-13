WITH last_days AS (
    SELECT 
        COUNT(*) AS total_last_count
    FROM order_details od
    WHERE DATE(od.created_at) >= '2025-01-05' AND DATE(od.created_at) <= '2025-01-06'
),
previous_days AS (
    SELECT 
        COUNT(*) AS total_previous_count
    FROM order_details od
    WHERE DATE(od.created_at) >= '2025-01-03' AND DATE(od.created_at) <= '2025-01-04'
),
daily_orders AS (
    SELECT 
        DATE(od.created_at) AS order_date,
        COUNT(*) AS total_order
    FROM order_details od
    WHERE DATE(od.created_at) >= '2025-01-03' AND DATE(od.created_at) <= '2025-01-06'
    GROUP BY DATE(od.created_at)
)
SELECT 
    (SELECT COUNT(*) FROM order_details od WHERE DATE(od.created_at) >= '2025-01-05' AND DATE(od.created_at) <= '2025-01-06') AS total_order,
    (SELECT AVG(total_order) FROM daily_orders) AS overall_average_order,
    ld.total_last_count,
    pd.total_previous_count,
    COALESCE(
        ROUND(
            ((ld.total_last_count - pd.total_previous_count) / 
             NULLIF(pd.total_previous_count, 0)) * 100, 
            2
        ), 
        0
    ) AS comparisons_percentage
FROM last_days ld, previous_days pd;

---------------------------- Brand Wise Search-------------------

WITH daily_orders AS (
    SELECT 
        DATE(od.created_at) AS order_date,
        p.brand_id,
        COUNT(*) AS total_order
    FROM order_details od
    JOIN products p ON od.product_id = p.id
    WHERE DATE(od.created_at) >= '2025-01-03' AND DATE(od.created_at) <= '2025-01-06'
    AND p.brand_id = 14  -- Filter by brand_id
    GROUP BY DATE(od.created_at), p.brand_id
),
last_days AS (
    SELECT 
        p.brand_id,
        COUNT(*) AS total_last_count
    FROM order_details od
    JOIN products p ON od.product_id = p.id
    WHERE DATE(od.created_at) >= '2025-01-05' AND DATE(od.created_at) <= '2025-01-06'
    AND p.brand_id = 14  -- Filter by brand_id
    GROUP BY p.brand_id
),
previous_days AS (
    SELECT 
        p.brand_id,
        COUNT(*) AS total_previous_count
    FROM order_details od
    JOIN products p ON od.product_id = p.id
    WHERE DATE(od.created_at) >= '2025-01-03' AND DATE(od.created_at) <= '2025-01-04'
    AND p.brand_id = 14  -- Filter by brand_id
    GROUP BY p.brand_id
)
SELECT 
    ld.brand_id,
    ld.total_last_count,
    (SELECT AVG(total_order) FROM daily_orders WHERE brand_id = ld.brand_id) AS overall_average_order,
    pd.total_previous_count,
    COALESCE(
        ROUND(
            ((ld.total_last_count - pd.total_previous_count) / 
             NULLIF(pd.total_previous_count, 0)) * 100, 
            2
        ), 
        0
    ) AS comparisons_percentage
FROM last_days ld
JOIN previous_days pd ON ld.brand_id = pd.brand_id;

---------------------------------- Category Wise Search----------------------------
WITH daily_orders AS (
    SELECT 
        DATE(od.created_at) AS order_date,
        p.category_id,
        COUNT(*) AS total_order
    FROM order_details od
    JOIN products p ON od.product_id = p.id
    WHERE DATE(od.created_at) >= '2025-01-03' AND DATE(od.created_at) <= '2025-01-06'
    AND p.category_id = 255
    GROUP BY DATE(od.created_at), p.category_id
),
last_days AS (
    SELECT 
        p.category_id,
        COUNT(*) AS total_last_count
    FROM order_details od
    JOIN products p ON od.product_id = p.id
    WHERE DATE(od.created_at) >= '2025-01-05' AND DATE(od.created_at) <= '2025-01-06'
    AND p.category_id = 255
    GROUP BY p.category_id
),
previous_days AS (
    SELECT 
        p.category_id,
        COUNT(*) AS total_previous_count
    FROM order_details od
    JOIN products p ON od.product_id = p.id
    WHERE DATE(od.created_at) >= '2025-01-03' AND DATE(od.created_at) <= '2025-01-04'
    AND p.category_id = 255
    GROUP BY p.category_id
)
SELECT 
    ld.category_id,
    ld.total_last_count,
    (SELECT AVG(total_order) FROM daily_orders WHERE category_id = ld.category_id) AS overall_average_order,
    pd.total_previous_count,
    COALESCE(
        ROUND(
            ((ld.total_last_count - pd.total_previous_count) / 
             NULLIF(pd.total_previous_count, 0)) * 100, 
            2
        ), 
        0
    ) AS comparisons_percentage
FROM last_days ld
JOIN previous_days pd ON ld.category_id = pd.category_id;
