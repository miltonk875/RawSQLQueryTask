------------------------------ DEfault Order Count-------------------------------
	
	SELECT 
        DATE(od.created_at) AS order_date,
        COUNT(*) AS total_order
    FROM order_details od
    JOIN products p ON od.product_id = p.id
    WHERE DATE(od.created_at) >= '2025-01-01' AND DATE(od.created_at) <= '2025-01-11'
    GROUP BY DATE(od.created_at)
	
------------------------------ Brand wise Order Count-------------------------------
	
SELECT 
        DATE(od.created_at) AS order_date,
        COUNT(*) AS total_order
    FROM order_details od
    JOIN products p ON od.product_id = p.id
    WHERE DATE(od.created_at) >= '2025-01-01' AND DATE(od.created_at) <= '2025-01-11'
	AND p.brand_id=14
    GROUP BY DATE(od.created_at)
	
------------------------------ Category wise Order Count-------------------------------
	
SELECT 
        DATE(od.created_at) AS order_date,
        COUNT(*) AS total_order
    FROM order_details od
    JOIN products p ON od.product_id = p.id
    WHERE DATE(od.created_at) >= '2025-01-01' AND DATE(od.created_at) <= '2025-01-11'
	AND p.category_id=255
    GROUP BY DATE(od.created_at)