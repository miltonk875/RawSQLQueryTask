SELECT 
    p.id AS product_id,
    p.name AS product_name,
    COALESCE(COUNT(DISTINCT w.id), 0) AS total_wishlist,
    COALESCE(COUNT(DISTINCT c.id), 0) AS total_cart_items
FROM products p
LEFT JOIN wishlists w ON w.product_id = p.id
LEFT JOIN carts c ON c.product_id = p.id
WHERE (w.created_at IS NULL OR (DATE(w.created_at) >= '2025-01-01' AND DATE(w.created_at) <= '2025-01-15'))
  AND (c.created_at IS NULL OR (DATE(c.created_at) >= '2025-01-01' AND DATE(c.created_at) <= '2025-01-15'))
GROUP BY p.id, p.name
HAVING total_wishlist != 0 OR total_cart_items != 0
ORDER BY p.id;

-----------With Search And Date Wise-------------------
SELECT 
    p.id AS product_id,
    p.name AS product_name,
    COALESCE(COUNT(DISTINCT w.id), 0) AS total_wishlist,
    COALESCE(COUNT(DISTINCT c.id), 0) AS total_cart_items
FROM products p
LEFT JOIN wishlists w ON w.product_id = p.id
LEFT JOIN carts c ON c.product_id = p.id
WHERE (w.created_at IS NULL OR (DATE(w.created_at) >= '2025-01-01' AND DATE(w.created_at) <= '2025-01-15'))
  AND (c.created_at IS NULL OR (DATE(c.created_at) >= '2025-01-01' AND DATE(c.created_at) <= '2025-01-15'))
  AND p.id=13
GROUP BY p.id, p.name
HAVING total_wishlist != 0 OR total_cart_items != 0
ORDER BY p.id;

