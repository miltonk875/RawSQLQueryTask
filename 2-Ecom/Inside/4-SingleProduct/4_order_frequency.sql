-------------------------------------------- Order Frequency * ------------------------------------------
SELECT 
    od.product_id,
    COUNT(od.order_id) AS total_orders,
    COUNT(DISTINCT o.user_id) AS unique_customers,
    ROUND(
        IF(COUNT(DISTINCT o.user_id) > 0, 
            COUNT(od.order_id) / COUNT(DISTINCT o.user_id), 
            0), 2) AS order_frequency
FROM order_details od
JOIN orders o ON od.order_id = o.id
WHERE od.product_id = 136
AND o.created_at BETWEEN '2024-02-01' AND '2024-02-28'
GROUP BY od.product_id;