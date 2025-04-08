--------------------------------- Total Orders ----------------------------
SELECT 
    ecom.ecom_orders,
    pos.pos_orders,
    (ecom.ecom_orders + pos.pos_orders) AS total_combined_orders
FROM 
    (SELECT COUNT(id) AS ecom_orders
     FROM bbbd_ecommerce_test.orders
     WHERE DATE(created_at) BETWEEN '2025-04-07' AND '2025-04-08') ecom
CROSS JOIN
    (SELECT COUNT(*) AS pos_orders
     FROM pos.transactions
     WHERE vendor_id IN (2,3,5)
     AND type = 'sell'
     AND DATE(created_at) BETWEEN '2025-04-07' AND '2025-04-08') pos;
	 
	 
--------------------------------- Total Orders as percentage ----------------------------

SELECT 
    ecom_new.new_order as ecom_new_order,
    ecom_old.old_order as ecom_old_order,
    ROUND(
        ((ecom_new.new_order - ecom_old.old_order) / ecom_old.old_order) * 100, 
        2
    ) AS ecom_order_percentage,
    pos_new.new_order as pos_new_order,
    pos_old.old_order as pos_old_order,
    ROUND(
        ((pos_new.new_order - pos_old.old_order) / pos_old.old_order) * 100, 
        2
    ) AS pos_order_percentage,
    ROUND(
        ((ecom_new.new_order - ecom_old.old_order) / ecom_old.old_order) * 100, 
        2
    ) + ROUND(
        ((pos_new.new_order - pos_old.old_order) / pos_old.old_order) * 100, 
        2
    ) AS total_order_percentage
FROM 
    (
        -- Ecommerce New period order
        SELECT 
            COUNT(*) AS new_order
        FROM 
            bbbd_ecommerce_test.orders AS o
        WHERE 
            DATE(o.created_at) BETWEEN '2025-04-07' AND '2025-04-08'
    ) AS ecom_new,
    (
        -- Ecommerce Old period order
        SELECT 
            COUNT(*) AS old_order
        FROM 
            bbbd_ecommerce_test.orders AS o
        WHERE 
            DATE(o.created_at) BETWEEN '2025-04-05' AND '2025-04-06'
    ) AS ecom_old,
    (
        -- POS New period order
        SELECT 
            COUNT(*) AS new_order
        FROM 
            pos.transactions as ts
        WHERE 
            ts.vendor_id IN (2,3,5)
            AND ts.type = 'sell'
            AND DATE(ts.created_at) BETWEEN '2025-04-06' AND '2025-04-08'
    ) AS pos_new,
    (
        -- POS Old period order
        SELECT 
            COUNT(*) AS old_order
        FROM 
            pos.transactions as ts
        WHERE 
            ts.vendor_id IN (2,3,5)
            AND ts.type = 'sell'
            AND DATE(ts.created_at) BETWEEN '2025-04-05' AND '2025-04-06'
    ) AS pos_old;