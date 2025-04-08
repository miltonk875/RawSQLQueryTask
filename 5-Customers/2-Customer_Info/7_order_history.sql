---------------------------------------------------- Default All & By Date-------------------------------------------------
SELECT  
    DATE(o.created_at) AS order_date,
    o.id AS order_id,
    '' AS product_list,
    ROUND(SUM(od.quantity)) AS quantity,
    CONCAT(o.grand_total, ' QAR') AS order_amount,
    CASE 
        WHEN o.shipping_cost IS NULL THEN 'Free' 
        WHEN o.shipping_cost = 0 THEN 'Free' 
        ELSE 'Paid' 
    END AS delivery,
    CASE  
        WHEN MIN(od.price) IS NULL THEN 'Yes'  
        WHEN MIN(od.price) = 0.00 THEN 'Yes'  
        ELSE 'No'  
    END AS Gift,
    CASE 
        WHEN (SELECT DATE(created_at) 
              FROM bbbd_ecommerce_test.orders 
              WHERE user_id = o.user_id 
              AND created_at < o.created_at 
              ORDER BY created_at DESC 
              LIMIT 1) IS NULL 
        THEN 0  -- If NULL, set to 0
        WHEN DATEDIFF(DATE(o.created_at), 
                      (SELECT DATE(created_at) 
                       FROM bbbd_ecommerce_test.orders 
                       WHERE user_id = o.user_id 
                       AND created_at < o.created_at 
                       ORDER BY created_at DESC 
                       LIMIT 1)) = 0 
        THEN 1  -- If 0, set to 1
        ELSE DATEDIFF(DATE(o.created_at), 
                      (SELECT DATE(created_at) 
                       FROM bbbd_ecommerce_test.orders 
                       WHERE user_id = o.user_id 
                       AND created_at < o.created_at 
                       ORDER BY created_at DESC 
                       LIMIT 1))  
    END AS days_difference
FROM bbbd_ecommerce_test.orders o
JOIN bbbd_ecommerce_test.order_details od ON od.order_id = o.id
WHERE  
    o.user_id = 17554  
-- AND DATE(o.created_at) BETWEEN '2025-03-01' AND '2025-03-18'  
GROUP BY o.id, order_date, o.grand_total, o.shipping_cost
ORDER BY o.id DESC;


---------------------------------------------------- Order ID Wise Click Products Show-------------------------------------------------
SELECT 
	  CASE 
        WHEN (SELECT DATE(created_at) 
              FROM bbbd_ecommerce_test.orders 
              WHERE user_id = o.user_id 
              AND created_at < o.created_at 
              ORDER BY created_at DESC 
              LIMIT 1) IS NULL 
        THEN 0  -- If NULL, set to 0
        WHEN DATEDIFF(DATE(o.created_at), 
                      (SELECT DATE(created_at) 
                       FROM bbbd_ecommerce_test.orders 
                       WHERE user_id = o.user_id 
                       AND created_at < o.created_at 
                       ORDER BY created_at DESC 
                       LIMIT 1)) = 0 
        THEN 1  -- If 0, set to 1
        ELSE DATEDIFF(DATE(o.created_at), 
                      (SELECT DATE(created_at) 
                       FROM bbbd_ecommerce_test.orders 
                       WHERE user_id = o.user_id 
                       AND created_at < o.created_at 
                       ORDER BY created_at DESC 
                       LIMIT 1))  
    END AS days_difference,
    o.id AS order_id,
    p.name as product_list,
    CONCAT(od.quantity, ' pcs') AS quantity,
    CONCAT(od.price, 'QAR') AS price
FROM bbbd_ecommerce_test.orders o
JOIN bbbd_ecommerce_test.order_details od ON od.order_id = o.id
JOIN bbbd_ecommerce_test.products p ON od.product_id = p.id
WHERE od.order_id = 51347