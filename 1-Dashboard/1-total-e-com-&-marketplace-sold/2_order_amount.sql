/******************************************* Total Amount *************************/
SELECT 
    FORMAT(ecom.ecom_order_amount, 0) AS ecom_order_amount,
    FORMAT(pos.pos_order_amount, 0) AS pos_order_amount,
    FORMAT(ecom.ecom_order_amount + pos.pos_order_amount, 0) AS total_combined_order_amount
FROM 
    (SELECT COALESCE(SUM(grand_total), 0) AS ecom_order_amount
     FROM bbbd_ecommerce_test.orders
     WHERE DATE(created_at) BETWEEN '2025-04-07' AND '2025-04-08') ecom
CROSS JOIN
    (SELECT COALESCE(SUM(final_total), 0) AS pos_order_amount
     FROM pos.transactions
     WHERE vendor_id IN (2,3,5)
     AND type = 'sell'
     AND DATE(created_at) BETWEEN '2025-04-07' AND '2025-04-08') pos

	 
/******************************************* Total Order Amount Percentage *************************/

SELECT 
    ecom_new.new_order_amount as ecom_new_order_amount,
    ecom_old.old_order_amount as ecom_old_order_amount,
    ROUND(
        ((ecom_new.new_order_amount - ecom_old.old_order_amount) / ecom_old.old_order_amount) * 100, 
        2
    ) AS ecom_order_amount_percentage,
    pos_new.new_order_amount as pos_new_order_amount,
    pos_old.old_order_amount as pos_old_order_amount,
    ROUND(
        ((pos_new.new_order_amount - pos_old.old_order_amount) / pos_old.old_order_amount) * 100, 
        2
    ) AS pos_order_amount_percentage,
    ROUND(
        ((ecom_new.new_order_amount - ecom_old.old_order_amount) / ecom_old.old_order_amount) * 100, 
        2
    ) + ROUND(
        ((pos_new.new_order_amount - pos_old.old_order_amount) / pos_old.old_order_amount) * 100, 
        2
    ) AS total_order_amount_percentage
FROM 
    (
        -- Ecommerce New period order
        SELECT 
            COALESCE(SUM(grand_total), 0) AS new_order_amount
        FROM 
            bbbd_ecommerce_test.orders AS o
        WHERE 
            DATE(o.created_at) BETWEEN '2025-04-07' AND '2025-04-08'
    ) AS ecom_new,
    (
        -- Ecommerce Old period order
        SELECT 
            COALESCE(SUM(grand_total), 0) AS old_order_amount
        FROM 
            bbbd_ecommerce_test.orders AS o
        WHERE 
            DATE(o.created_at) BETWEEN '2025-04-05' AND '2025-04-06'
    ) AS ecom_old,
    (
        -- POS New period order
        SELECT 
            COALESCE(SUM(final_total), 0) AS new_order_amount
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
            COALESCE(SUM(final_total), 0) AS old_order_amount
        FROM 
            pos.transactions as ts
        WHERE 
            ts.vendor_id IN (2,3,5)
            AND ts.type = 'sell'
            AND DATE(ts.created_at) BETWEEN '2025-04-05' AND '2025-04-06'
    ) AS pos_old;