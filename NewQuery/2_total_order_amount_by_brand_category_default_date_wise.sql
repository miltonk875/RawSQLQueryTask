WITH last_days AS (
    SELECT 
    ROUND(SUM(quantity * price)) AS total_last_amount
    FROM order_details od
    WHERE DATE(od.created_at) >= '2025-01-10' AND DATE(od.created_at) <= '2025-01-11'
),
previous_days AS (
    SELECT 
    ROUND(SUM(quantity * price)) AS total_previous_amount
    FROM order_details od
    WHERE DATE(od.created_at) >= '2025-01-08' AND DATE(od.created_at) <= '2025-01-09'
)
SELECT 
    (SELECT  FORMAT(ROUND(SUM(quantity * price)),2) FROM order_details od WHERE DATE(od.created_at) >= '2025-01-05' AND DATE(od.created_at) <= '2025-01-06') AS total_order_amount,
    COALESCE(
        ROUND(
            ((ld.total_last_amount - pd.total_previous_amount) / 
             NULLIF(pd.total_previous_amount, 0)) * 100, 
            2
        ), 
        0
    ) AS comparisons_percentage
FROM last_days ld, previous_days pd;

---------------------------- Brand Wise Search-------------------

WITH last_days AS (
    SELECT 
        p.brand_id,
        ROUND(SUM(od.quantity * od.price)) AS total_last_amount
    FROM order_details od
    JOIN products p ON od.product_id = p.id
    WHERE DATE(od.created_at) >= '2025-01-05' AND DATE(od.created_at) <= '2025-01-06'
      AND p.brand_id = 14
    GROUP BY p.brand_id
),
previous_days AS (
    SELECT 
        p.brand_id,
        ROUND(SUM(od.quantity * od.price)) AS total_previous_amount
    FROM order_details od
    JOIN products p ON od.product_id = p.id
    WHERE DATE(od.created_at) >= '2025-01-03' AND DATE(od.created_at) <= '2025-01-04'
      AND p.brand_id = 14
    GROUP BY p.brand_id
)
SELECT 
    ld.brand_id,
    ld.total_last_amount,
    pd.total_previous_amount,
    COALESCE(
        ROUND(
            ((ld.total_last_amount - pd.total_previous_amount) / 
             NULLIF(pd.total_previous_amount, 0)) * 100, 
            2
        ), 
        0
    ) AS comparison_percentage
FROM last_days ld
JOIN previous_days pd ON ld.brand_id = pd.brand_id;


---------------------------------- Category Wise Search----------------------------
WITH last_days AS (
    SELECT 
        p.category_id,
        ROUND(SUM(od.quantity * od.price)) AS total_last_amount
    FROM order_details od
    JOIN products p ON od.product_id = p.id
    WHERE DATE(od.created_at) >= '2025-01-05' AND DATE(od.created_at) <= '2025-01-06'
      AND p.category_id = 255 -- Change to your desired category_id filter, or remove if not needed
    GROUP BY p.category_id
),
previous_days AS (
    SELECT 
        p.category_id,
        ROUND(SUM(od.quantity * od.price)) AS total_previous_amount
    FROM order_details od
    JOIN products p ON od.product_id = p.id
    WHERE DATE(od.created_at) >= '2025-01-03' AND DATE(od.created_at) <= '2025-01-04'
      AND p.category_id = 255 -- Change to your desired category_id filter, or remove if not needed
    GROUP BY p.category_id
)
SELECT 
    ld.category_id,
    ld.total_last_amount,
    pd.total_previous_amount,
    COALESCE(
        ROUND(
            ((ld.total_last_amount - pd.total_previous_amount) / 
             NULLIF(pd.total_previous_amount, 0)) * 100, 
            2
        ), 
        0
    ) AS comparison_percentage
FROM last_days ld
JOIN previous_days pd ON ld.category_id = pd.category_id;