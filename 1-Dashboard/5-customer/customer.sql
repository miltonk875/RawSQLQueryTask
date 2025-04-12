/******************************************* Total Customer *******************************/

SELECT COUNT(*) AS total_customers
FROM (
    SELECT COUNT(DISTINCT ad.user_id)
    FROM bbbd_ecommerce_test.addresses ad
    WHERE DATE(ad.created_at) BETWEEN '2025-04-12' AND '2025-04-12'
    GROUP BY ad.phone
) AS grouped_data;


/******************************************* Total New Customer *******************************/

SELECT COUNT(*) AS total_customers
FROM (
    SELECT user_id
    FROM bbbd_ecommerce_test.orders
    WHERE DATE(orders.created_at) BETWEEN '2025-04-12' AND '2025-04-12'
    GROUP BY user_id
    HAVING COUNT(*) = 1
) AS single_order_users;
