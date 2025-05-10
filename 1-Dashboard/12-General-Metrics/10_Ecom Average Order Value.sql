SELECT 
    FORMAT(ROUND(SUM(od.quantity*od.price) / (DATEDIFF('2025-05-10', '2025-05-10') + 1)),0) AS ecom_average_order_amount
FROM 
    bbbd_ecommerce_test.order_details AS od
WHERE DATE(od.created_at) >= '2025-05-10'
    AND DATE(od.created_at) <= '2025-05-10';