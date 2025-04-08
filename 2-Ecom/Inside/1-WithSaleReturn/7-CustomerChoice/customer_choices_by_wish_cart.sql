SELECT 
    p.id AS product_id,
    p.name AS product_name,
    CONCAT('product/', p.slug) AS product_link,
    COALESCE(COUNT(DISTINCT w.id), 0) AS total_wishlist,
    COALESCE(COUNT(DISTINCT c.id), 0) AS total_cart_items
FROM bbbd_ecommerce_test.products p
JOIN wishlists w ON w.product_id = p.id
JOIN carts c ON c.product_id = p.id
WHERE (w.created_at IS NULL OR (DATE(w.created_at) >= '2025-02-26' AND DATE(w.created_at) <= '2025-02-26'))
  AND (c.created_at IS NULL OR (DATE(c.created_at) >= '2025-02-26' AND DATE(c.created_at) <= '2025-02-26'))
GROUP BY p.id, p.name
HAVING total_wishlist != 0 OR total_cart_items != 0
ORDER BY p.id;

----------------- Search Data---------------------

SELECT 
    p.id AS product_id,
    p.name AS product_name,
	CONCAT('product/', p.slug) AS product_link,
    COALESCE(COUNT(DISTINCT w.id), 0) AS total_wishlist,
    COALESCE(COUNT(DISTINCT c.id), 0) AS total_cart_items
FROM bbbd_ecommerce_test.products p
JOIN wishlists w ON w.product_id = p.id
JOIN carts c ON c.product_id = p.id
WHERE (w.created_at IS NULL OR (DATE(w.created_at) >= '2025-02-01' AND DATE(w.created_at) <= '2025-02-08'))
  AND (c.created_at IS NULL OR (DATE(c.created_at) >= '2025-02-01' AND DATE(c.created_at) <= '2025-02-08'))
  --AND p.id=13
  --AND p.brand_id=16
  --AND p.category_id=255
GROUP BY p.id, p.name
HAVING total_wishlist != 0 OR total_cart_items != 0
ORDER BY p.id;
