CREATE VIEW bd_pos_invoices AS 
SELECT
    tsl.id AS transaction_sell_id,
    tsl.transaction_id AS transaction_id,
    p.id AS product_id,
    p.name AS product_name,
    p.sku AS product_sku,
    FORMAT(ep.unit_price, 2) AS ecom_price,
    FORMAT(ep.discount, 2) AS ep_discount,
    FORMAT(ep.unit_price - ep.discount, 2) AS ep_offer_price,
    ep.discount_type AS ep_discount_type,
    DATE_FORMAT(FROM_UNIXTIME(ep.discount_end_date), '%Y-%m-%d') AS ep_discount_end,
    
    CASE 
        WHEN COALESCE(ep.discount, 0) = 0 THEN 0
        ELSE 1 
    END AS ep_discount_have, 

    '' AS ecom_end,
    CAST(tsl.quantity AS UNSIGNED) AS pos_quantity,
    FORMAT(tsl.unit_price_before_discount, 2) AS pos_regular_price,
    FORMAT(tsl.unit_price, 2) AS pos_unit_price,
    tsl.line_discount_type AS pos_discount_type,
    FORMAT(tsl.line_discount_amount, 2) AS pos_discount_amount,
    FORMAT(tsl.unit_price_inc_tax, 2) AS pos_payable_price,
	FORMAT(tsl.unit_price_inc_tax * tsl.quantity, 2) AS pos_sub_total,
    DATE_FORMAT(tsl.created_at, '%Y-%m-%d, %h:%i %p') AS pos_created_date
FROM  
    u_pos.transaction_sell_lines tsl
JOIN  
    u_pos.transactions ts ON tsl.transaction_id = ts.id
JOIN  
    u_pos.products p ON tsl.product_id = p.id
JOIN 
    bbbd_ecommerce.products ep ON tsl.product_id = ep.id
WHERE 
    ts.type = 'sell'
ORDER BY  
    tsl.id DESC;
