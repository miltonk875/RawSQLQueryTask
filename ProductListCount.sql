--Total Products 
SELECT 
	count(*) 
FROM 
    bbbd_ecommerce.products AS p
-- Active Products

SELECT 
	count(*)
FROM 
    bbbd_ecommerce.products AS p
WHERE 
    p.published = 1
	
--- In Stock Products
SELECT 
    p.id AS product_id,
    p.name AS product_name,
    CAST(IFNULL(SUM(vld.qty_available), 0) AS UNSIGNED) AS current_stock
FROM 
    bbbd_ecommerce.products AS p
LEFT JOIN 
    u_pos.variation_location_details AS vld ON p.id = vld.product_id
WHERE 
    p.published = 1
GROUP BY 
    p.id, p.name
HAVING 
    current_stock > 0;
	
--- Out of Stock

SELECT 
    p.id AS product_id,
    p.name AS product_name,
    CAST(IFNULL(SUM(vld.qty_available), 0) AS UNSIGNED) AS current_stock
FROM 
    bbbd_ecommerce.products AS p
LEFT JOIN 
    u_pos.variation_location_details AS vld ON p.id = vld.product_id
WHERE 
    p.published = 1
GROUP BY 
    p.id, p.name
HAVING 
    current_stock==0;