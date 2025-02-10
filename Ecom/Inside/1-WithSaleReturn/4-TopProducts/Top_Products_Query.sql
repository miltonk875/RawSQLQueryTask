SELECT 
    p.id AS product_id, 
    p.name AS product_name, 
    COUNT(od.product_id) AS orders,
    ROUND(COALESCE(SUM(od.quantity * od.price), 0)) AS amount,
    ROUND(
        COALESCE(
            (
                (
                    SELECT COUNT(*) 
                    FROM bbbd_ecommerce_test.order_details AS od_new
                    WHERE DATE(od_new.created_at) >= '2025-02-08' 
                    AND DATE(od_new.created_at) <= '2025-02-09' 
                    AND od_new.product_id = p.id
                ) - 
                (
                    SELECT COUNT(*) 
                    FROM bbbd_ecommerce_test.order_details AS od_old
                    WHERE DATE(od_old.created_at) >= '2025-02-06' 
                    AND DATE(od_old.created_at) <= '2025-02-07' 
                    AND od_old.product_id = p.id
                )
            ) / NULLIF(
                (
                    SELECT COUNT(*) 
                    FROM bbbd_ecommerce_test.order_details AS od_old
                    WHERE DATE(od_old.created_at) >= '2025-02-06' 
                    AND DATE(od_old.created_at) <= '2025-02-07' 
                    AND od_old.product_id = p.id
                ), 0
            ) * 100, 0.00
        ), 2
    ) AS percentage_change
FROM 
    bbbd_ecommerce_test.order_details od
JOIN 
    bbbd_ecommerce_test.products p ON od.product_id = p.id
WHERE 
    DATE(od.created_at) >= '2025-02-08' 
    AND DATE(od.created_at) <= '2025-02-09'
GROUP BY 
    p.id, p.name
ORDER BY 
    orders DESC
LIMIT 1000;

------------------------------------------ Search Brand,Category & Products ---------------------------------------------
SELECT 
    p.id AS product_id, 
    p.name AS product_name, 
    COUNT(od.product_id) AS orders,
    ROUND(COALESCE(SUM(od.quantity * od.price), 0)) AS amount,
    ROUND(
        COALESCE(
            (
                (
                    SELECT COUNT(*) 
                    FROM bbbd_ecommerce_test.order_details AS od_new
                    WHERE DATE(od_new.created_at) >= '2025-02-08' 
                    AND DATE(od_new.created_at) <= '2025-02-09' 
                    AND od_new.product_id = p.id
                ) - 
                (
                    SELECT COUNT(*) 
                    FROM bbbd_ecommerce_test.order_details AS od_old
                    WHERE DATE(od_old.created_at) >= '2025-02-06' 
                    AND DATE(od_old.created_at) <= '2025-02-07' 
                    AND od_old.product_id = p.id
                )
            ) / NULLIF(
                (
                    SELECT COUNT(*) 
                    FROM bbbd_ecommerce_test.order_details AS od_old
                    WHERE DATE(od_old.created_at) >= '2025-02-06' 
                    AND DATE(od_old.created_at) <= '2025-02-07' 
                    AND od_old.product_id = p.id
                ), 0
            ) * 100, 0.00
        ), 2
    ) AS percentage_change
FROM 
    bbbd_ecommerce_test.order_details od
JOIN 
    bbbd_ecommerce_test.products p ON od.product_id = p.id
WHERE 
    DATE(od.created_at) >= '2025-02-01' 
    AND DATE(od.created_at) <= '2025-02-09'
	--AND p.id=136
	--AND p.category_id=255
	--AND p.brand_id=14
GROUP BY 
    p.id, p.name
ORDER BY 
    orders DESC
LIMIT 1000;