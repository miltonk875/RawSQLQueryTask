------------------------------ Date Wise Order Count-------------------------------
SELECT 
    DATE(od.created_at) AS order_date,
    COUNT(*) AS total_orders  -- Counts the number of order rows
FROM 
    bbbd_ecommerce_test.order_details od
JOIN 
    bbbd_ecommerce_test.products p ON od.product_id = p.id
WHERE 
     DATE(od.created_at) >= '2025-02-01' 
	 AND DATE(od.created_at) <= '2025-02-09'
	 --AND p.id=136
	 --AND p.brand_id=136
	 --AND p.category_id=255
GROUP BY 
    order_date;
   