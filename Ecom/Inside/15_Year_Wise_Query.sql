SELECT
    YEAR(o.created_at) AS year,
    COUNT(*) AS total_sale_orders,
    ROUND(SUM(o.grand_total), 2) AS total_sale_amount,
    IFNULL(o_prev.orders, 0) AS prev_order_sale,
    ROUND(
        CASE 
            WHEN IFNULL(o_prev.orders, 0) = 0 THEN 0
            ELSE (COUNT(*) - o_prev.orders) / IFNULL(o_prev.orders, 1) * 100
        END, 2
    ) AS percentage_change
FROM
    qatar_ecommerce_db.orders AS o
LEFT JOIN (
    SELECT 
        YEAR(created_at) AS prev_year,
        COUNT(*) AS orders
    FROM 
        qatar_ecommerce_db.orders
    GROUP BY 
        YEAR(created_at)
) AS o_prev 
    ON YEAR(o.created_at) = o_prev.prev_year + 1
GROUP BY
    YEAR(o.created_at), o_prev.orders
ORDER BY
    YEAR(o.created_at) DESC
