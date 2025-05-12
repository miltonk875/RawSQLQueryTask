SELECT COUNT(*) AS total_5_riyal_products
FROM bbbd_ecommerce_test.products AS p
WHERE p.unit_price <= 5;