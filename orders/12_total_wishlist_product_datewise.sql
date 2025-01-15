-----------Total Wishlist Order By Date Wise-------------------
SELECT 
COUNT(*) AS total_order
FROM wishlists w
WHERE DATE(w.created_at) >= '2025-01-15' 
AND DATE(w.created_at) <= '2025-01-15'

-----------Total Wish List With Search And Date Wise-------------------
const searchType = "id";
const searchId = 136;
  
SELECT 
COUNT(*) AS total_order
FROM wishlists w
JOIN products p ON w.product_id = p.id
WHERE DATE(w.created_at) >= '2025-01-15' 
AND DATE(w.created_at) <= '2025-01-15'
AND p.${searchType} = ${searchId}
GROUP BY p.${searchType}
