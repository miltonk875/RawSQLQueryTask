/******************************************* Total Customer *******************************/

SELECT COUNT(*) AS total_customers
FROM (
    SELECT COUNT(DISTINCT ad.user_id)
    FROM bbbd_ecommerce_test.addresses ad
    WHERE DATE(ad.created_at) BETWEEN '2025-04-12' AND '2025-04-12'
    GROUP BY ad.phone
) AS grouped_data;


/******************************************* Total New Customer *******************************/

SELECT COUNT(*) AS total_new_customers
FROM (
    SELECT user_id
    FROM bbbd_ecommerce_test.orders
    WHERE DATE(orders.created_at) BETWEEN '2025-04-10' AND '2025-04-17'
    GROUP BY user_id
    HAVING COUNT(*) = 1
) AS new_customers;

/******************************************* Total Customer Comparisons *******************************/

SELECT 
    new.new_customers,
    old.old_customers,
    ROUND(
        ((new.new_customers - old.old_customers) / NULLIF(old.old_customers, 0)) * 100,
        2
    ) AS comparison_percentage
FROM 
    (
        SELECT COUNT(DISTINCT user_id) AS new_customers
        FROM bbbd_ecommerce_test.orders
        WHERE DATE(orders.created_at) BETWEEN '2025-04-17' AND '2025-04-17'
    ) AS new,
    (
        SELECT COUNT(DISTINCT user_id) AS old_customers
        FROM bbbd_ecommerce_test.orders
        WHERE DATE(orders.created_at) BETWEEN '2025-04-16' AND '2025-04-16'
    ) AS old;
