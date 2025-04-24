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
    JSON_EXTRACT(orders.shipping_address, '$.city_id') AS city_id,
    JSON_UNQUOTE(JSON_EXTRACT(orders.shipping_address, '$.city_name')) AS city_name,
    JSON_EXTRACT(orders.shipping_address, '$.zone_id') AS zone_id,
    JSON_UNQUOTE(JSON_EXTRACT(orders.shipping_address, '$.zone_name')) AS zone_name,
    JSON_EXTRACT(orders.shipping_address, '$.area_id') AS area_id,
    JSON_UNQUOTE(JSON_EXTRACT(orders.shipping_address, '$.area_name')) AS area_name,
    JSON_UNQUOTE(JSON_EXTRACT(orders.shipping_address, '$.courier_type')) AS courier_type,
    orders.grand_total AS order_amount,
    orders.src AS order_from,
    orders.delivery_status AS order_status,
    DATE_FORMAT(orders.created_at, '%l:%i %p') AS order_time,
    DATE_FORMAT(orders.created_at, '%Y-%m-%d') AS order_date,
	orders.courier_sent as courier_sent,
	orders.sent_date as sent_date,
	orders.consignment_id as consignment_id
FROM 
    orders
ORDER BY 
    orders.id DESC;