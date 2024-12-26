SELECT 
    SUM(CASE WHEN src = 'web' THEN 1 ELSE 0 END) AS web_order,
    SUM(CASE WHEN src = 'app' THEN 1 ELSE 0 END) AS app_order
FROM orders
WHERE DATE(created_at) >= '2024-12-22'
  AND DATE(created_at) <= '2024-12-23';