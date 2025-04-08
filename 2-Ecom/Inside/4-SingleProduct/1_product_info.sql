-------------------------------------------- Product Details Query From Ecom DB ------------------------------------------
SELECT 
    p.id AS product_id,
    p.name AS product_name,
    CONCAT('https://beautyboothqa.com/product/', p.slug) AS product_link,
    CONCAT('https://admin.beautyboothqa.com/', u.file_name) AS product_image,
    p.brand_id AS brand_id,
    b.name AS brand_name,
    p.category_id AS category_id,
    c.name AS category_name
FROM 
    bbbd_ecommerce_test.products AS p
LEFT JOIN 
    bbbd_ecommerce_test.uploads AS u ON p.thumbnail_img = u.id
LEFT JOIN 
    bbbd_ecommerce_test.brands AS b ON p.brand_id = b.id
LEFT JOIN 
    bbbd_ecommerce_test.categories AS c ON p.category_id = c.id
WHERE 
    p.id = 136;

-------------------------------------------- Product Category -> Sub Category -> Chaild Category ------------------------------------------
SELECT 
    COALESCE(c3.name, c2.name, c1.name) AS main_category, 
    CASE 
        WHEN c3.name IS NOT NULL THEN c2.name
        WHEN c2.name IS NOT NULL THEN c1.name
        ELSE NULL 
    END AS sub_category, 
    CASE 
        WHEN c3.name IS NOT NULL THEN c1.name
        ELSE NULL 
    END AS child_category
FROM bbbd_ecommerce_test.product_categories pc
JOIN bbbd_ecommerce_test.categories c1 ON pc.category_id = c1.id
LEFT JOIN bbbd_ecommerce_test.categories c2 ON c1.parent_id = c2.id
LEFT JOIN bbbd_ecommerce_test.categories c3 ON c2.parent_id = c3.id
WHERE pc.product_id = 136
ORDER BY pc.category_id DESC
LIMIT 1;
