SELECT 
    SUM(product_total) AS best_selling
FROM (
    SELECT 
        product_id,
        SUM(quantity) AS product_total
    FROM 
        bbbd_ecommerce_test.order_details
    GROUP BY 
        product_id
) AS per_product;

-------------------------------------------- Date Wise Best Selling ------------------------------------------
SELECT 
    SUM(product_total) AS best_selling
FROM (
    SELECT 
        od.product_id,
        SUM(od.quantity) AS product_total
    FROM 
        bbbd_ecommerce_test.order_details AS od
    WHERE 
		DATE(od.created_at) >= '2025-05-10' AND DATE(od.created_at) <= '2025-05-10'
    GROUP BY 
        od.product_id
) AS per_product;
