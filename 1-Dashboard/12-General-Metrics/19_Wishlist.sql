SELECT 
    COALESCE(COUNT(DISTINCT w.id), 0) AS total_wishlist
FROM bbbd_ecommerce_test.products p
JOIN wishlists w ON w.product_id = p.id

	-------------------------------------- Date Wise-------------------------------------

SELECT 
    COALESCE(COUNT(DISTINCT w.id), 0) AS total_wishlist
FROM bbbd_ecommerce_test.products p
JOIN wishlists w ON w.product_id = p.id

  AND (w.created_at IS NULL OR (DATE(w.created_at) >= '2025-05-10' AND DATE(w.created_at) <= '2025-05-10'));
