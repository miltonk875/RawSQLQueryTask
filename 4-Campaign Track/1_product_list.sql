------------------------------------------------------------- 1 Stock Product List ----------------------------------------
SELECT 
    p.id as product_id,
    p.name AS product_name,
    ROUND(SUM(vld.qty_available)) AS stock
FROM 
    bbbd_ecommerce_test.products AS p
LEFT JOIN 
    pos.variation_location_details AS vld ON p.id = vld.product_id
GROUP BY 
    p.id, p.name
HAVING 
    stock > 0;
	


