------------------------------------------------------------- 1 Stock Product List ----------------------------------------
SELECT 
    p.id as product_id,
    p.name AS product_name,
    ROUND(SUM(vld.qty_available)) AS stock
FROM 
    bbbd_ecommerce_test.products AS p
LEFT JOIN 
    pos.variation_location_details AS vld ON p.id = vld.product_id
GROUP BY 
    p.id, p.name
HAVING 
    stock > 0;
	
------------------------------------------------------------- 2 Product Filters ----------------------------------------
Ads Types
1) Facebook
2) Google

-- Campain Name List
SELECT 
    c.id as campaign_id,
    c.title as campaign_name
FROM 
    bbbd_ecommerce_test.campaigns as c
WHERE 
    NOW() BETWEEN FROM_UNIXTIME(c.start_date) AND FROM_UNIXTIME(c.end_date);
	
------------------------------------------------------------- 3 Search Products ----------------------------------------

SELECT  
    p.id,  
    p.name AS product_name,  
    b.name AS brand,  
    ROUND(SUM(vld.qty_available)) AS stock,  
    IFNULL(t.total_sold, 0) AS orders,  
    ROUND(  
        CASE   
            WHEN IFNULL(c.previous_sale, 0) = 0 THEN 0  
            ELSE (IFNULL(b.current_sale, 0) - IFNULL(c.previous_sale, 0)) / IFNULL(c.previous_sale, 1) * 100  
        END, 2  
    ) AS trend  
FROM bbbd_ecommerce_test.campaign_products AS cp  
LEFT JOIN bbbd_ecommerce_test.products AS p ON cp.product_id = p.id  
LEFT JOIN bbbd_ecommerce_test.brands AS b ON p.brand_id = b.id  

-- Subquery for current orders within a specific date range  
LEFT JOIN (  
    SELECT   
        od.product_id,  
        ROUND(SUM(od.quantity)) AS current_sale  
    FROM   
        bbbd_ecommerce_test.order_details AS od  
    WHERE   
        DATE(od.created_at) BETWEEN '2025-03-01' AND '2025-03-31'  
    GROUP BY   
        od.product_id  
) AS b ON p.id = b.product_id  

-- Subquery for previous sales data for the fixed products  
LEFT JOIN (  
    SELECT   
        od.product_id,  
        ROUND(SUM(od.quantity)) AS previous_sale  
    FROM   
        bbbd_ecommerce_test.order_details AS od  
    WHERE   
        DATE(od.created_at) BETWEEN '2025-02-01' AND '2025-02-28'  
    GROUP BY   
        od.product_id  
) AS c ON p.id = c.product_id  

-- Subquery for total_sold over the entire time range  
LEFT JOIN (  
    SELECT   
        od.product_id,  
        ROUND(SUM(od.quantity)) AS total_sold  
    FROM   
        bbbd_ecommerce_test.order_details AS od  
    GROUP BY   
        od.product_id  
) AS t ON p.id = t.product_id  

-- Join with variation_location_details for current stock  
LEFT JOIN pos.variation_location_details AS vld ON p.id = vld.product_id  

WHERE   
    cp.campaign_id = 38  

GROUP BY   
    p.id  

HAVING   
    orders > 0  

ORDER BY   
    orders DESC;



