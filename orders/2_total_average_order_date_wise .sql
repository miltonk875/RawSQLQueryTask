-----------Total Average Order By Date Wise-------------------
SELECT 
    COALESCE(CAST(ROUND(COUNT(*) / COUNT(DISTINCT DATE(od.created_at))) AS SIGNED), 0) AS average_orders
FROM order_details od
WHERE DATE(od.created_at) >= '2025-01-11' 
  AND DATE(od.created_at) <= '2025-01-12';
  
-----------Total Order With Product Search And Date Wise-------------------
SELECT 
    COALESCE(CAST(ROUND(COUNT(*) / COUNT(DISTINCT DATE(od.created_at))) AS SIGNED), 0) AS average_orders
FROM order_details od
JOIN products p ON od.product_id = p.id
WHERE DATE(od.created_at) >= '2025-01-07' 
  AND DATE(od.created_at) <= '2025-01-08'
  AND p.id = 136;

-----------Total Order With Brand Search And Date Wise-------------------
SELECT 
    COALESCE(CAST(ROUND(COUNT(*) / COUNT(DISTINCT DATE(od.created_at))) AS SIGNED), 0) AS average_orders
FROM order_details od
JOIN products p ON od.product_id = p.id
WHERE DATE(od.created_at) >= '2025-01-07' 
  AND DATE(od.created_at) <= '2025-01-08'
  AND p.brand_id = 14

-----------Total Order With Category Search And Date Wise-------------------
SELECT 
    COALESCE(CAST(ROUND(COUNT(*) / COUNT(DISTINCT DATE(od.created_at))) AS SIGNED), 0) AS average_orders
FROM order_details od
JOIN products p ON od.product_id = p.id
WHERE DATE(od.created_at) >= '2025-01-07' 
  AND DATE(od.created_at) <= '2025-01-08'
  AND p.category_id = 255

