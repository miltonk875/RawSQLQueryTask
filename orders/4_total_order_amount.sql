-----------Total Order Amount By Date Wise-------------------
SELECT 
ROUND(SUM(quantity * price)) AS total_order_amount
FROM order_details od
WHERE DATE(od.created_at) >= '2025-01-12' 
AND DATE(od.created_at) <= '2025-01-13'

-----------Total Order With Product Search And Date Wise-------------------
SELECT 
ROUND(SUM(quantity * price)) AS total_order_amount
FROM order_details od
JOIN products p ON od.product_id = p.id
WHERE DATE(od.created_at) >= '2025-01-12' 
AND DATE(od.created_at) <= '2025-01-13'
AND p.id = 20
GROUP BY p.id

-----------Total Order With Brand Search And Date Wise-------------------
SELECT 
ROUND(SUM(quantity * price)) AS total_order_amount
FROM order_details od
JOIN products p ON od.product_id = p.id
WHERE DATE(od.created_at) >= '2025-01-12' 
AND DATE(od.created_at) <= '2025-01-13'
AND p.brand_id = 14
GROUP BY p.brand_id

-----------Total Order With Category Search And Date Wise-------------------
SELECT 
ROUND(SUM(quantity * price)) AS total_order_amount
FROM order_details od
JOIN products p ON od.product_id = p.id
WHERE DATE(od.created_at) >= '2025-01-12' 
AND DATE(od.created_at) <= '2025-01-13'
AND p.category_id = 255
GROUP BY p.category_id
