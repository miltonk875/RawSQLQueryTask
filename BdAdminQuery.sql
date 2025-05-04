---- BBB Order Shoipment Qiery for VIEW

CREATE VIEW bbb_order_shipments AS
SELECT 
    orders.id AS order_id,
    orders.user_id AS customer_id,
    JSON_UNQUOTE(JSON_EXTRACT(orders.shipping_address, '$.name')) AS name,
    JSON_UNQUOTE(JSON_EXTRACT(orders.shipping_address, '$.phone')) AS phone,
    JSON_UNQUOTE(JSON_EXTRACT(orders.shipping_address, '$.email')) AS email,
    JSON_UNQUOTE(JSON_EXTRACT(orders.shipping_address, '$.address')) AS address,
    JSON_UNQUOTE(JSON_EXTRACT(orders.shipping_address, '$.city')) AS city,
    JSON_UNQUOTE(JSON_EXTRACT(orders.shipping_address, '$.city_id')) AS city_id,
    JSON_UNQUOTE(JSON_EXTRACT(orders.shipping_address, '$.city_name')) AS city_name,
    JSON_UNQUOTE(JSON_EXTRACT(orders.shipping_address, '$.zone_id')) AS zone_id,
    JSON_UNQUOTE(JSON_EXTRACT(orders.shipping_address, '$.zone_name')) AS zone_name,
    JSON_UNQUOTE(JSON_EXTRACT(orders.shipping_address, '$.area_id')) AS area_id,
    JSON_UNQUOTE(JSON_EXTRACT(orders.shipping_address, '$.area_name')) AS area_name,
    JSON_UNQUOTE(JSON_EXTRACT(orders.shipping_address, '$.courier_type')) AS courier_type,
    orders.grand_total AS order_amount,
    bia.payable_amount AS payable_amount,
    orders.src AS order_from,
    orders.delivery_status AS order_status,
    DATE_FORMAT(orders.created_at, '%l:%i %p') AS order_time,
    DATE_FORMAT(orders.created_at, '%Y-%m-%d') AS order_date,
	orders.courier_sent as courier_sent,
	orders.sent_date as sent_date,
	orders.consignment_id as consignment_id,
	DATE_FORMAT(ou.created_at, '%l:%i %p') AS processing_time,
    DATE_FORMAT(ou.created_at, '%Y-%m-%d') AS processing_date
FROM 
    orders
JOIN 
	order_updates AS ou ON orders.id = ou.order_id
JOIN 
	bbb_invoice_amount AS bia ON orders.id= bia.order_id
where 
	ou.status='processing'
ORDER BY 
    orders.id ASC;
	
	
CREATE VIEW bbb_invoice_amount AS
SELECT 
    o.id AS order_id,
    (COALESCE(SUM(od.price), 0) + COALESCE(SUM(od.shipping_cost), 0) - o.advance_payment_value - o.coupon_discount) AS payable_amount
FROM 
    orders AS o
LEFT JOIN 
    order_details AS od ON o.id = od.order_id
WHERE 
    o.delivery_status = 'processing'
GROUP BY 
    o.id, o.advance_payment_value, o.coupon_discount
	
	
--Not Equal Order amount vs invoice amount

SELECT * FROM `bbb_order_shipments` WHERE order_date BETWEEN '2025-04-15' AND '2025-04-27' AND order_amount !=payable_amount