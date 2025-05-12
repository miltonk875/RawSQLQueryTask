SELECT count(*)
FROM bbbd_ecommerce_test.products
WHERE created_at >= NOW() - INTERVAL 180 DAY AND published = 1;