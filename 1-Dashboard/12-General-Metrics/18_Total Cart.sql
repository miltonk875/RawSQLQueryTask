SELECT 
    COALESCE(COUNT(DISTINCT c.id), 0) AS total_cart_items
FROM bbbd_ecommerce_test.products p
JOIN carts c ON c.product_id = p.id;

	-------------------------------------- Date Wise-------------------------------------

SELECT 
    COALESCE(COUNT(DISTINCT c.id), 0) AS total_cart_items
FROM bbbd_ecommerce_test.products p
JOIN carts c ON c.product_id = p.id
  AND (c.created_at IS NULL OR (DATE(c.created_at) >= '2025-05-10' AND DATE(c.created_at) <= '2025-05-10'));