SELECT COUNT(*) AS total_20_riyal_products
FROM bbbd_ecommerce_test.products AS p
WHERE p.unit_price > 5 AND p.unit_price <= 20;