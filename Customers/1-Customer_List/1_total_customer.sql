----------------------------------------------------- Deafult All Customers-------------------------------------
SELECT COUNT(*) AS total_customers
FROM (
    SELECT COUNT(DISTINCT ad.user_id)
    FROM bbbd_ecommerce_test.addresses ad
    GROUP BY ad.phone, ad.email
) AS grouped_data;
----------------------------------------------------- Total Customers By Date Filter-------------------------------------
SELECT COUNT(*) AS total_customers
FROM (
    SELECT COUNT(DISTINCT ad.user_id)
    FROM bbbd_ecommerce_test.addresses ad
    WHERE DATE(ad.created_at) BETWEEN '2025-03-13' AND '2025-03-13'
    GROUP BY ad.phone, ad.email
) AS grouped_data;
----------------------------------------------------- Total Customers Comparisions By Date Filter-------------------------------------
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
			SELECT COUNT(DISTINCT ad.user_id)
			FROM bbbd_ecommerce_test.addresses ad
			WHERE DATE(ad.created_at) BETWEEN '2025-03-11' AND '2025-03-11'
			GROUP BY ad.phone, ad.email
		) AS grouped_data
    ) AS new,
    (
		SELECT COUNT(*) AS old_customer
		FROM (
			SELECT COUNT(DISTINCT ad.user_id)
			FROM bbbd_ecommerce_test.addresses ad
			WHERE DATE(ad.created_at) BETWEEN '2025-03-10' AND '2025-03-10'
			GROUP BY ad.phone, ad.email
		) AS grouped_data
    ) AS old;