SELECT 
    CONCAT('Quarter ', q.quarter, ' (',
        CASE 
            WHEN q.quarter = 1 THEN 'Jan-Apr'
            WHEN q.quarter = 2 THEN 'May-Aug'
            WHEN q.quarter = 3 THEN 'Sep-Dec'
        END, 
    ')') AS period,
    IFNULL(COUNT(DISTINCT o.id), 0) AS total_sale_orders,
    IFNULL(ROUND(SUM(o.grand_total), 2), 0) AS total_sale_amount,
    IFNULL(MAX(od_prev.total_orders), 0) AS prev_order_sale, -- Use MAX() to ensure it's an aggregated value
    ROUND(
        CASE 
            WHEN IFNULL(MAX(od_prev.total_orders), 0) = 0 THEN 0
            ELSE (COUNT(DISTINCT o.id) - MAX(od_prev.total_orders)) / IFNULL(MAX(od_prev.total_orders), 1) * 100
        END, 2
    ) AS percentage_change
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
LEFT JOIN (
    SELECT 
        YEAR(created_at) AS prev_year,
        COUNT(DISTINCT id) AS total_orders
    FROM 
        qatar_ecommerce_db.orders
    WHERE YEAR(created_at) = 2024
    GROUP BY 
        YEAR(created_at)
) AS od_prev ON YEAR(o.created_at) = od_prev.prev_year + 1
GROUP BY
    q.quarter
ORDER BY
    FIELD(q.quarter, 1, 2, 3);
