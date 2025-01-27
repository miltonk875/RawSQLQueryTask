-----------------------------------Total Order Amount Comparisons-------------------
SELECT 
   ROUND(((total_average_order_amount_1 - total_average_order_amount_2) / total_average_order_amount_2) * 100, 2) AS percentage_difference
FROM (
    SELECT 
        ROUND(SUM(average_order_amount) / COUNT(average_order_amount), 2) AS total_average_order_amount_1
    FROM (
        SELECT 
            ROUND(SUM(quantity * price) / COUNT(DISTINCT order_id), 2) AS average_order_amount
        FROM order_details od
        JOIN 
            products p ON od.product_id = p.id
			
        WHERE DATE(od.created_at) >= '2025-01-10' 
        AND DATE(od.created_at) <= '2025-01-11'
        GROUP BY DATE(od.created_at)
    ) AS subquery
) AS query1,
(
    SELECT 
        ROUND(SUM(average_order_amount) / COUNT(average_order_amount), 2) AS total_average_order_amount_2
    FROM (
        SELECT 
            ROUND(SUM(quantity * price) / COUNT(DISTINCT order_id), 2) AS average_order_amount
        FROM order_details od
        JOIN 
            products p ON od.product_id = p.id
   
        AND DATE(od.created_at) >= '2025-01-08' 
        AND DATE(od.created_at) <= '2025-01-09'
        GROUP BY DATE(od.created_at)
    ) AS subquery
) AS query2;

-----------------------------------Brand Wise Order Comparisons-------------------
SELECT 
   ROUND(((total_average_order_amount_1 - total_average_order_amount_2) / total_average_order_amount_2) * 100, 2) AS percentage_difference
FROM (
    SELECT 
        ROUND(SUM(average_order_amount) / COUNT(average_order_amount), 2) AS total_average_order_amount_1
    FROM (
        SELECT 
            ROUND(SUM(quantity * price) / COUNT(DISTINCT order_id), 2) AS average_order_amount
        FROM order_details od
        JOIN 
            products p ON od.product_id = p.id
        WHERE p.brand_id=14
        AND DATE(od.created_at) >= '2025-01-10' 
        AND DATE(od.created_at) <= '2025-01-11'
        GROUP BY DATE(od.created_at)
    ) AS subquery
) AS query1,
(
    SELECT 
        ROUND(SUM(average_order_amount) / COUNT(average_order_amount), 2) AS total_average_order_amount_2
    FROM (
        SELECT 
            ROUND(SUM(quantity * price) / COUNT(DISTINCT order_id), 2) AS average_order_amount
        FROM order_details od
        JOIN 
            products p ON od.product_id = p.id
        WHERE p.brand_id=14
        AND DATE(od.created_at) >= '2025-01-08' 
        AND DATE(od.created_at) <= '2025-01-09'
        GROUP BY DATE(od.created_at)
    ) AS subquery
) AS query2;

-----------------------------------Category Wise Order Comparisons-------------------
SELECT 
   ROUND(((total_average_order_amount_1 - total_average_order_amount_2) / total_average_order_amount_2) * 100, 2) AS percentage_difference
FROM (
    SELECT 
        ROUND(SUM(average_order_amount) / COUNT(average_order_amount), 2) AS total_average_order_amount_1
    FROM (
        SELECT 
            ROUND(SUM(quantity * price) / COUNT(DISTINCT order_id), 2) AS average_order_amount
        FROM order_details od
        JOIN 
            products p ON od.product_id = p.id
        WHERE p.category_id=255
        AND DATE(od.created_at) >= '2025-01-10' 
        AND DATE(od.created_at) <= '2025-01-11'
        GROUP BY DATE(od.created_at)
    ) AS subquery
) AS query1,
(
    SELECT 
        ROUND(SUM(average_order_amount) / COUNT(average_order_amount), 2) AS total_average_order_amount_2
    FROM (
        SELECT 
            ROUND(SUM(quantity * price) / COUNT(DISTINCT order_id), 2) AS average_order_amount
        FROM order_details od
        JOIN 
            products p ON od.product_id = p.id
         WHERE p.category_id=255
        AND DATE(od.created_at) >= '2025-01-08' 
        AND DATE(od.created_at) <= '2025-01-09'
        GROUP BY DATE(od.created_at)
    ) AS subquery
) AS query2;

