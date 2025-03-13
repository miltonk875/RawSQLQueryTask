SELECT 
    b.id AS brand_id, 
    b.name AS brand_name, 
    bo.orders, 
    bo.amount,
    ROUND(
        COALESCE(
            ((oc.current_orders - oc.previous_orders) / NULLIF(oc.previous_orders, 0)) * 100, 
            0.00
        ), 
        2
    ) AS percentage_change
FROM 
    (
        SELECT 
            p.brand_id, 
            COUNT(DISTINCT od.product_id) AS orders, 
            ROUND(COALESCE(SUM(od.quantity * od.price), 0)) AS amount
        FROM 
            bbbd_ecommerce_test.order_details od
        JOIN 
            bbbd_ecommerce_test.products p ON od.product_id = p.id
        WHERE 
            od.created_at BETWEEN '2025-02-01' AND '2025-02-31'
        GROUP BY 
            p.brand_id
    ) bo
JOIN 
    bbbd_ecommerce_test.brands b ON bo.brand_id = b.id
LEFT JOIN 
    (
        SELECT 
            p.brand_id, 
            SUM(CASE WHEN od.created_at BETWEEN '2025-02-01' AND '2025-02-31' THEN 1 ELSE 0 END) AS current_orders,
            SUM(CASE WHEN od.created_at BETWEEN '2025-01-01' AND '2025-01-31' THEN 1 ELSE 0 END) AS previous_orders
        FROM 
            bbbd_ecommerce_test.order_details od
        JOIN 
            bbbd_ecommerce_test.products p ON od.product_id = p.id
        GROUP BY 
            p.brand_id
    ) oc ON bo.brand_id = oc.brand_id
ORDER BY 
    bo.orders DESC;

------------------------------------------ Search Brand,Category & Products ---------------------------------------------
SELECT 
    b.id AS brand_id, 
    b.name AS brand_name, 
    bo.orders, 
    bo.amount,
    ROUND(
        COALESCE(
            ((oc.current_orders - oc.previous_orders) / NULLIF(oc.previous_orders, 0)) * 100, 
            0.00
        ), 
        2
    ) AS percentage_change
FROM 
    (
        SELECT 
            p.brand_id, 
            COUNT(DISTINCT od.product_id) AS orders, 
            ROUND(COALESCE(SUM(od.quantity * od.price), 0)) AS amount
        FROM 
            bbbd_ecommerce_test.order_details od
        JOIN 
            bbbd_ecommerce_test.products p ON od.product_id = p.id
        WHERE 
            od.created_at BETWEEN '2025-02-01' AND '2025-02-31'
		--AND p.id=136
		--AND p.category_id=255
		--AND p.brand_id=14
        GROUP BY 
            p.brand_id
    ) bo
JOIN 
    bbbd_ecommerce_test.brands b ON bo.brand_id = b.id
LEFT JOIN 
    (
        SELECT 
            p.brand_id, 
            SUM(CASE WHEN od.created_at BETWEEN '2025-02-01' AND '2025-02-31' THEN 1 ELSE 0 END) AS current_orders,
            SUM(CASE WHEN od.created_at BETWEEN '2025-01-01' AND '2025-01-31' THEN 1 ELSE 0 END) AS previous_orders
        FROM 
            bbbd_ecommerce_test.order_details od
        JOIN 
            bbbd_ecommerce_test.products p ON od.product_id = p.id
        GROUP BY 
            p.brand_id
    ) oc ON bo.brand_id = oc.brand_id
ORDER BY 
    bo.orders DESC;