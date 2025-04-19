SELECT 
    city,
    ROUND(COUNT(*) * 100 / total.total_count, 0) AS percentage
FROM (
    SELECT 
        ad.city as city
    FROM bbbd_ecommerce_test.orders as od
    JOIN addresses as ad ON od.user_id = ad.user_id
    WHERE DATE(od.created_at) BETWEEN '2025-04-15' AND '2025-04-19'
    GROUP BY od.user_id, ad.city
) AS user_cities
CROSS JOIN (
    SELECT COUNT(DISTINCT od.user_id) as total_count
    FROM bbbd_ecommerce_test.orders as od
    JOIN addresses as ad ON od.user_id = ad.user_id
    WHERE DATE(od.created_at) BETWEEN '2025-04-15' AND '2025-04-19'
) AS total
GROUP BY city, total.total_count
ORDER BY percentage DESC