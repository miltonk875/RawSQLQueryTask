/************************************ By Default 1 week ****************************/


SELECT 
    COUNT(o.id) AS total_order,
	FORMAT(ROUND(SUM(grand_total)),0) AS total_amount
FROM 
    bbbd_ecommerce_test.orders AS o
WHERE 
    DATE(o.created_at) BETWEEN '2025-04-01' AND '2025-04-07'