------------------------------------------- Campaign Wise List ----------------------------------

SELECT 
    c.id,
    c.title,
    DATE_FORMAT(FROM_UNIXTIME(start_date), '%Y-%m-%d') AS start_date,
    DATE_FORMAT(FROM_UNIXTIME(end_date), '%Y-%m-%d') AS end_date,
	(SELECT COUNT(*) 
     FROM bbbd_ecommerce_test.campaign_products cp 
     WHERE cp.campaign_id = c.id) AS total_products
FROM 
    bbbd_ecommerce_test.campaigns as c
WHERE 
    NOW() BETWEEN FROM_UNIXTIME(c.start_date) AND FROM_UNIXTIME(c.end_date);
	
----------------------------------------------- Campaign ID Wise Products ------------------------------------------------------------
SELECT 
    p.id,
    p.name AS product_name,
    b.name AS brand,
    c.name AS category,
    p.unit_price AS price,
    ROUND(SUM(vld.qty_available)) AS stock,
    IFNULL(t.total_sold, 0) AS orders,
	'0.00%' as trend
FROM bbbd_ecommerce_test.campaign_products AS cp
LEFT JOIN bbbd_ecommerce_test.products AS p ON cp.product_id = p.id
LEFT JOIN bbbd_ecommerce_test.categories AS c ON p.category_id = c.id
LEFT JOIN bbbd_ecommerce_test.brands AS b ON p.brand_id = b.id

-- Subquery for total_sold over the entire time range
LEFT JOIN (
    SELECT 
        od.product_id,
        ROUND(SUM(od.quantity)) AS total_sold
    FROM 
        bbbd_ecommerce_test.order_details AS od
    GROUP BY 
        od.product_id
) AS t ON p.id = t.product_id

-- Join with variation_location_details for current stock
LEFT JOIN pos.variation_location_details AS vld ON p.id = vld.product_id
WHERE 
    cp.campaign_id = 38
GROUP BY 
    p.id, 
    p.name, 
    b.name, 
    c.name, 
    p.unit_price, 
    t.total_sold
ORDER BY 
    orders DESC;