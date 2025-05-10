SELECT 
    FORMAT(ecom.ecom_amount, 0) AS ecom_amount,
    FORMAT(pos.pos_amount, 0) AS pos_amount,
    FORMAT((ecom.ecom_amount + pos.pos_amount), 0) AS total_amount
FROM 
    (SELECT ROUND(SUM(grand_total), 0) AS ecom_amount
     FROM bbbd_ecommerce_test.orders
     WHERE DATE(created_at) = '2025-05-08') ecom
CROSS JOIN
    (SELECT ROUND(SUM(final_total), 0) AS pos_amount
     FROM pos.transactions
     WHERE vendor_id IN (2,3,5)
       AND type = 'sell'
       AND DATE(created_at) = '2025-05-08') pos;
