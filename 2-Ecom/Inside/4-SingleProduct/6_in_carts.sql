
-------------------------------------------- In Cart & Wishlist ------------------------------------------
SELECT 
    COALESCE(COUNT(DISTINCT w.id), 0) AS total_wishlist,
    COALESCE(COUNT(DISTINCT c.id), 0) AS total_cart_items
FROM bbbd_ecommerce_test.products p
LEFT JOIN wishlists w 
    ON w.product_id = p.id 
    AND (w.created_at IS NULL 
         OR (DATE(w.created_at) >= '2025-02-01' 
             AND DATE(w.created_at) <= '2025-02-27'))
LEFT JOIN carts c 
    ON c.product_id = p.id 
    AND (c.created_at IS NULL 
         OR (DATE(c.created_at) >= '2025-02-01' 
             AND DATE(c.created_at) <= '2025-02-27'))
WHERE p.id = 136
GROUP BY p.id;
