----------------------------------------------------- Total Customers-------------------------------------
SELECT COUNT(*) AS total_customers
FROM (
    SELECT COUNT(DISTINCT ad.user_id)
    FROM bbbd_ecommerce_test.addresses ad
    WHERE DATE(ad.created_at) BETWEEN '2025-03-08' AND '2025-03-08'
    GROUP BY ad.phone
) AS grouped_data;

----------------------------------------------------- Total Customers List-------------------------------------
SELECT 
    addresses.id,
    MIN(addresses.name) AS name,
    addresses.email,
    addresses.phone,
    addresses.address,
    MIN(addresses.city) AS city,
    DATE(addresses.created_at) AS created_at
FROM bbbd_ecommerce_test.addresses
GROUP BY addresses.id, addresses.email, addresses.phone, addresses.address, addresses.created_at
ORDER BY created_at DESC
LIMIT 50;