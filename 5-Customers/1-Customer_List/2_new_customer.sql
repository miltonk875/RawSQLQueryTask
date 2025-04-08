----------------------------------------------------- Total New All Customers------------------------------------
SELECT COUNT(*) AS total_new_customers
FROM (
    SELECT MIN(id) AS first_order_id
    FROM bbbd_ecommerce_test.orders
    GROUP BY user_id
) AS first_orders;

----------------------------------------------------- Total New All Customers By Date-------------------------------------
SELECT COUNT(*) AS total_new_customers
FROM (
    SELECT MIN(id) AS first_order_id
    FROM bbbd_ecommerce_test.orders
    	WHERE DATE(orders.created_at) BETWEEN '2025-03-11' AND '2025-03-11'
    GROUP BY user_id
) AS first_orders;


----------------------------------------------------- Total Customers Comparisions-------------------------------------
SELECT 
	new.new_customer,
	old.old_customer,
    ROUND(
        ((new.new_customer - old.old_customer) / old.old_customer) * 100, 
        2
    ) AS customer_trend
FROM 
    (
		SELECT COUNT(*) AS new_customer
		FROM (
			SELECT MIN(id) AS first_order_id
			FROM bbbd_ecommerce_test.orders
				WHERE DATE(orders.created_at) BETWEEN '2025-03-11' AND '2025-03-11'
			GROUP BY user_id
		) AS first_orders
    ) AS new,
    (
		SELECT COUNT(*) AS old_customer
		FROM (
			SELECT MIN(id) AS first_order_id
			FROM bbbd_ecommerce_test.orders
				WHERE DATE(orders.created_at) BETWEEN '2025-03-10' AND '2025-03-10'
			GROUP BY user_id
		) AS first_old_orders
    ) AS old;