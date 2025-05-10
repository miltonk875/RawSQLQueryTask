SELECT 
    (ecom.ecom_orders + pos.pos_orders) AS total_orders
FROM 
    (SELECT COUNT(id) AS ecom_orders
     FROM bbbd_ecommerce_test.orders
     WHERE DATE(created_at) = '2025-05-08') ecom
CROSS JOIN
    (SELECT COUNT(*) AS pos_orders
     FROM pos.transactions
     WHERE vendor_id IN (2,3,5)
       AND type = 'sell'
       AND DATE(created_at) = '2025-05-08') pos;
