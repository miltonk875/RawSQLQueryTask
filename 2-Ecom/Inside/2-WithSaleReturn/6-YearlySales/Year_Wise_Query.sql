SELECT
    YEAR(o.created_at) AS year,
    COUNT(*) AS orders,
    FORMAT(ROUND(SUM(grand_total), 0), 0) AS amount,
    ROUND(
        CASE 
            WHEN IFNULL(o_prev.orders, 0) = 0 THEN 0
            ELSE (COUNT(*) - o_prev.orders) / IFNULL(o_prev.orders, 1) * 100
        END, 2
    ) AS trend
FROM
    bbbd_ecommerce_test.orders AS o
LEFT JOIN (
    SELECT 
        YEAR(created_at) AS prev_year,
        COUNT(*) AS orders
    FROM 
        bbbd_ecommerce_test.orders
	WHERE 
		delivery_status='cancelled'
    GROUP BY 
        YEAR(created_at)
) AS o_prev 
    ON YEAR(o.created_at) = o_prev.prev_year + 1
WHERE 
		delivery_status='cancelled'
GROUP BY
    YEAR(o.created_at), o_prev.orders
ORDER BY
    YEAR(o.created_at) DESC
	
------------------------------------ Sub Quater Query ----------------------------------------
SELECT 
    CONCAT('Quarter ', q.quarter, ' (',
        CASE 
            WHEN q.quarter = 1 THEN 'Jan-Apr'
            WHEN q.quarter = 2 THEN 'May-Aug'
            WHEN q.quarter = 3 THEN 'Sep-Dec'
        END, 
    ')') AS period,
    IFNULL(COUNT(DISTINCT o.id), 0) AS orders,
    IFNULL(ROUND(SUM(o.grand_total), 2), 0) AS amount,
    ROUND(
        CASE 
            WHEN IFNULL(MAX(od_prev.total_orders), 0) = 0 THEN 0
            ELSE (COUNT(DISTINCT o.id) - MAX(od_prev.total_orders)) / IFNULL(MAX(od_prev.total_orders), 1) * 100
        END, 2
    ) AS trend
FROM
    (SELECT 1 AS quarter
     UNION ALL
     SELECT 2
     UNION ALL
     SELECT 3) q
LEFT JOIN orders AS o
    ON ((q.quarter = 1 AND MONTH(o.created_at) BETWEEN 1 AND 4) OR
        (q.quarter = 2 AND MONTH(o.created_at) BETWEEN 5 AND 8) OR
        (q.quarter = 3 AND MONTH(o.created_at) BETWEEN 9 AND 12))
    AND YEAR(o.created_at) = 2025
	AND delivery_status='cancelled'
LEFT JOIN (
    SELECT 
        YEAR(created_at) AS prev_year,
        COUNT(DISTINCT id) AS total_orders
    FROM 
        bbbd_ecommerce_test.orders
    WHERE YEAR(created_at) = 2024
	AND delivery_status='cancelled'
    GROUP BY 
        YEAR(created_at)
) AS od_prev ON YEAR(o.created_at) = od_prev.prev_year + 1
GROUP BY
    q.quarter
ORDER BY
    FIELD(q.quarter, 1, 2, 3);