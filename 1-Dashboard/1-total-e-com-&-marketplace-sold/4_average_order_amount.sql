--------------------------------- Average Order Amount ----------------------------
SELECT 
    FORMAT(ecom.avg_order_value, 0) AS avg_ecom_order_value,
    FORMAT(pos.avg_order_value, 0) AS avg_pos_order_value,
    FORMAT((ecom.total_sales + pos.total_sales)/(ecom.order_count + pos.order_count), 0) AS combined_avg_order_value
FROM 
    (SELECT 
        SUM(grand_total) AS total_sales,
        COUNT(id) AS order_count,
        SUM(grand_total)/COUNT(id) AS avg_order_value
     FROM bbbd_ecommerce_test.orders
     WHERE DATE(created_at) BETWEEN '2025-04-07' AND '2025-04-08') ecom
CROSS JOIN
    (SELECT 
        SUM(final_total) AS total_sales,
        COUNT(id) AS order_count,
        SUM(final_total)/COUNT(id) AS avg_order_value
     FROM pos.transactions
     WHERE vendor_id IN (2,3,5)
     AND type = 'sell'
     AND DATE(created_at) BETWEEN '2025-04-07' AND '2025-04-08') pos;