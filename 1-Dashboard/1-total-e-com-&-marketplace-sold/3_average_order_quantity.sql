--------------------------------- Average Order Quantity ----------------------------
SELECT 
    ecom.average_ecom_orders,
    pos.average_pos_orders,
    (ecom.average_ecom_orders + pos.average_pos_orders) AS average_combined_orders
FROM 
    (SELECT ROUND(COUNT(id) / (DATEDIFF('2025-04-08', '2025-04-07') + 1)) AS average_ecom_orders
     FROM bbbd_ecommerce_test.orders
     WHERE DATE(created_at) BETWEEN '2025-04-07' AND '2025-04-08') ecom
CROSS JOIN
    (SELECT ROUND(COUNT(id) / (DATEDIFF('2025-04-08', '2025-04-07') + 1)) AS average_pos_orders
     FROM pos.transactions
     WHERE vendor_id IN (2,3,5)
     AND type = 'sell'
     AND DATE(created_at) BETWEEN '2025-04-07' AND '2025-04-08') pos;