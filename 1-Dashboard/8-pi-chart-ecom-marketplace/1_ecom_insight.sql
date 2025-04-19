---------------------------------------------------- Ecom Insight Top Sale Products By Date Wise ---------------------------
SELECT 
    p.name AS product_name,
    SUM(od.quantity) as total_sale_qty
FROM 
	bbbd_ecommerce_test.order_details AS od
LEFT JOIN 
	bbbd_ecommerce_test.products AS p ON od.product_id = p.id
WHERE 
	DATE(od.created_at) BETWEEN '2025-04-15' AND '2025-04-19'
GROUP BY p.name
ORDER BY total_sale_qty DESC

---------------------------------------------------- Marketplace Insight Top Sale Products By Date Wise ---------------------------
SELECT  
    p.name AS name,
    ROUND(COALESCE(SUM(tsl.quantity), 0)) AS qty
FROM  
    pos.transaction_sell_lines tsl
JOIN  
    pos.transactions ts ON tsl.transaction_id = ts.id
JOIN  
    pos.products p ON tsl.product_id = p.id
WHERE 
    DATE(tsl.created_at) BETWEEN '2025-04-15' AND '2025-04-19'
    AND ts.vendor_id IN (2,3,5)
GROUP BY p.name ORDER BY qty DESC