-----------Total Order By Date Wise-------------------
SELECT 
COUNT(*) AS total_order
FROM order_details od
WHERE DATE(od.created_at) >= '2025-01-05' 
AND DATE(od.created_at) <= '2025-01-06'

-----------Total Order With Product Search And Date Wise-------------------
SELECT 
COUNT(*) AS total_order
FROM order_details od
JOIN products p ON od.product_id = p.id
WHERE DATE(od.created_at) >= '2025-01-05' 
AND DATE(od.created_at) <= '2025-01-06'
AND p.id = 20
GROUP BY p.id

-----------Total Order With Brand Search And Date Wise-------------------
SELECT 
COUNT(*) AS total_order
FROM order_details od
JOIN products p ON od.product_id = p.id
WHERE DATE(od.created_at) >= '2025-01-05' 
AND DATE(od.created_at) <= '2025-01-06'
AND p.brand_id = 14
GROUP BY p.brand_id

-----------Total Order With Category Search And Date Wise-------------------
SELECT 
COUNT(*) AS total_order
FROM order_details od
JOIN products p ON od.product_id = p.id
WHERE DATE(od.created_at) >= '2025-01-05' 
AND DATE(od.created_at) <= '2025-01-06'
AND p.category_id = 255
GROUP BY p.category_id
