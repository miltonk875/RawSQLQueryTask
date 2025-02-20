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
	
-------------------------------------------- Product Life Time Sold  ------------------------------------------
SELECT 
    SUM(quantity) as life_time_sold
FROM 
    bbbd_ecommerce_test.order_details AS od
WHERE 
    od.product_id = 136;
	
-------------------------------------------- Current Stock From POS DB * ------------------------------------------
SELECT 
    CAST(SUM(vld.qty_available) AS UNSIGNED) AS current_stock
FROM 
    pos.variation_location_details AS vld
JOIN 
    pos.products AS p ON p.id = vld.product_id
WHERE 
    vld.product_id = 13;
-------------------------------------------- Order Frequency * ------------------------------------------
SELECT 
    COALESCE(
        CAST(SUM(od.quantity) AS UNSIGNED), 0
    ) AS total_orders
FROM 
    bbbd_ecommerce_test.order_details od
WHERE 
    DATE(od.created_at) >= '2025-02-20'
    AND DATE(od.created_at) <= '2025-02-20'
	
SELECT 
    COUNT(od.quantity) AS order_frequency
FROM 
    bbbd_ecommerce_test.order_details od
WHERE 
    DATE(od.created_at) >= '2025-02-20'
    AND DATE(od.created_at) <= '2025-02-20'
    AND od.product_id = 136;
	
-------------------------------------------- Order Frequency Comparisions ------------------------------------------
SELECT 
    COALESCE(
        ROUND(
            ((COALESCE(new.new_order, 0) - COALESCE(old.old_order, 0)) / 
            NULLIF(COALESCE(old.old_order, 0), 0)) * 100, 
            2
        ), 0
    ) AS order_frequency_comparisions
FROM 
    (
        -- New period order by current date range
        SELECT 
            COALESCE(COUNT(od.quantity), 0) AS new_order
        FROM 
            bbbd_ecommerce_test.order_details AS od
        JOIN 
            bbbd_ecommerce_test.products p ON od.product_id = p.id
        WHERE 
            DATE(od.created_at) >= '2025-02-18' AND DATE(od.created_at) <= '2025-02-20'
		 AND p.id=136
    ) AS new,
    (
        -- Old period order by old date range
        SELECT 
            COALESCE(COUNT(od.quantity), 0) AS old_order
        FROM 
            bbbd_ecommerce_test.order_details AS od
        JOIN
            bbbd_ecommerce_test.products p ON od.product_id = p.id
        WHERE 
            DATE(od.created_at) >= '2025-02-17' AND DATE(od.created_at) <= '2025-02-18'
		 AND p.id=136
    ) AS old;
-------------------------------------------- Today's Sales ------------------------------------------
SELECT 
    COALESCE(
        CAST(SUM(od.quantity) AS UNSIGNED), 0
    ) AS sales
FROM 
    bbbd_ecommerce_test.order_details od
WHERE 
    DATE(od.created_at) >= '2025-02-20'
    AND DATE(od.created_at) <= '2025-02-20'
    AND od.product_id=13

-------------------------------------------- Today's Sales Comparisions ------------------------------------------
SELECT 
	new.new_sales,
	old.old_sales,
    COALESCE(
        ROUND(
            ((COALESCE(new.new_sales, 0) - COALESCE(old.old_sales, 0)) / 
            NULLIF(COALESCE(old.old_sales, 0), 0)) * 100, 
            2
        ), 0
    ) AS sale_comparisions
FROM 
    (
        -- New sales by current date range
        SELECT 
            COALESCE(COUNT(od.quantity), 0) AS new_sales
        FROM 
            bbbd_ecommerce_test.order_details AS od
        JOIN 
            bbbd_ecommerce_test.products p ON od.product_id = p.id
        WHERE 
            DATE(od.created_at) >= '2025-02-18' AND DATE(od.created_at) <= '2025-02-20'
		 AND p.id=136
    ) AS new,
    (
        -- Old sales by old date range
        SELECT 
            COALESCE(COUNT(od.quantity), 0) AS old_sales
        FROM 
            bbbd_ecommerce_test.order_details AS od
        JOIN
            bbbd_ecommerce_test.products p ON od.product_id = p.id
        WHERE 
            DATE(od.created_at) >= '2025-02-17' AND DATE(od.created_at) <= '2025-02-18'
		 AND p.id=136
    ) AS old;
	
	
-------------------------------------------- In Cart & Wishlist ------------------------------------------

SELECT 
    COALESCE(COUNT(DISTINCT w.id), 0) AS total_wishlist,
    COALESCE(COUNT(DISTINCT c.id), 0) AS total_cart_items
FROM bbbd_ecommerce_test.products p
JOIN wishlists w ON w.product_id = p.id
JOIN carts c ON c.product_id = p.id
WHERE (w.created_at IS NULL OR (DATE(w.created_at) >= '2025-02-18' AND DATE(w.created_at) <= '2025-02-20'))
  AND (c.created_at IS NULL OR (DATE(c.created_at) >= '2025-02-18' AND DATE(c.created_at) <= '2025-02-20'))
  AND p.id=13
GROUP BY p.id, p.name
HAVING total_wishlist != 0 OR total_cart_items != 0
ORDER BY p.id;

-------------------------------------------- Product Prices ------------------------------------------
