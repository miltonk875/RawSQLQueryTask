SELECT  
  ad.id AS customer_id,
  ad.name AS customer_name,
  ad.email,
  ad.phone,
  '' as gender,
  '' as birthday,
    DATE(o.created_at) AS last_purchases,
    Date(u.created_at) as account_creation,
    '' as last_login,
    '' as customer_type,
    '' as loyalty_program_status,
  ad.address,
  ad.city,
  '' as state,
  ad.postal_code,
  ad.country
FROM  
  bbbd_ecommerce_test.addresses ad  
JOIN  
  bbbd_ecommerce_test.users u ON ad.user_id = u.id
JOIN  
  bbbd_ecommerce_test.orders o ON ad.user_id = o.user_id
WHERE  
  ad.user_id = 23880
