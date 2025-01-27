--SHow All Average Amount List
    -- SELECT 
      -- ROUND(SUM(quantity * price) / COUNT(DISTINCT order_id), 2) AS average_order_amount
    -- FROM order_details od
    -- WHERE DATE(od.created_at) >= '2025-01-10' 
      -- AND DATE(od.created_at) <= '2025-01-11'
    -- GROUP BY DATE(od.created_at)
	
--------------Brand _id
    -- SELECT 
      -- ROUND(SUM(quantity * price) / COUNT(DISTINCT order_id), 2) AS average_order_amount
    -- FROM order_details od
		-- products p ON od.product_id = p.id
	-- WHERE p.brand_id=14
    -- AND DATE(od.created_at) >= '2025-01-10' 
      -- AND DATE(od.created_at) <= '2025-01-11'
    -- GROUP BY DATE(od.created_at)
	
	


--Get All Average Amount By One Column (USE THIS Query)

SELECT 
   ROUND(SUM(average_order_amount) / COUNT(average_order_amount)) AS total_average_order_amount
FROM (
    SELECT 
        ROUND(SUM(quantity * price) / COUNT(DISTINCT order_id), 2) AS average_order_amount
    FROM order_details od
	
    WHERE DATE(od.created_at) >= '2025-01-10' 
      AND DATE(od.created_at) <= '2025-01-11'
    GROUP BY DATE(od.created_at)
) AS subquery;



--------------Get Total Average Amount By Brand

SELECT 
   ROUND(SUM(average_order_amount) / COUNT(average_order_amount)) AS total_average_order_amount
FROM (
    SELECT 
        ROUND(SUM(quantity * price) / COUNT(DISTINCT order_id), 2) AS average_order_amount
    FROM order_details od
JOIN 
	products p ON od.product_id = p.id
	WHERE p.brand_id=14
    AND DATE(od.created_at) >= '2025-01-08' 
      AND DATE(od.created_at) <= '2025-01-11'
    GROUP BY DATE(od.created_at)
) AS subquery;


SELECT 
   ROUND(SUM(average_order_amount) / COUNT(average_order_amount)) AS total_average_order_amount
FROM (
    SELECT 
        ROUND(SUM(quantity * price) / COUNT(DISTINCT order_id), 2) AS average_order_amount
    FROM order_details od
JOIN 
	products p ON od.product_id = p.id
	WHERE p.category_id=255
    AND DATE(od.created_at) >= '2025-01-08' 
      AND DATE(od.created_at) <= '2025-01-11'
    GROUP BY DATE(od.created_at)
) AS subquery;