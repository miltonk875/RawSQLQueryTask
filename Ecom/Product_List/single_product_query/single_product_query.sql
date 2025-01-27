-------------------------------------------- Product Details Query ------------------------------------------
SELECT 
    p.id AS product_id,
    p.name AS product_name,
    CONCAT('https://beautyboothqa.com/product/', p.slug) AS product_link,
    u.file_name AS file_name,
    p.brand_id AS brand_id,
    b.name AS brand_name,
    p.category_id AS category_id,
    c.name AS category_name
FROM 
    products AS p
LEFT JOIN 
    uploads AS u ON p.thumbnail_img = u.id
LEFT JOIN 
    brands AS b ON p.brand_id = b.id
LEFT JOIN 
    categories AS c ON p.category_id = c.id
WHERE 
    p.id = 136;
	
-------------------------------------------- Product Details Query ------------------------------------------

