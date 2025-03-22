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