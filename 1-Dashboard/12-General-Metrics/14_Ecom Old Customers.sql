SELECT COUNT(*) AS old_customers
FROM (
  SELECT o.user_id
  FROM bbbd_ecommerce_test.orders o
  JOIN bbbd_ecommerce_test.users u ON o.user_id = u.id
  WHERE u.user_type = 'customer'
  GROUP BY o.user_id
  HAVING COUNT(o.id) > 1
) AS old_customers;
