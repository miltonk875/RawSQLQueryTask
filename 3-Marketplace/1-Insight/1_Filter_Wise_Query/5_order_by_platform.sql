SELECT   
    v.id AS vendor_id,
    v.name AS vendor_name,
    COUNT(*) AS total_orders,
    ROUND(
        (COUNT(*) / 
        (SELECT COUNT(*)  
         FROM pos.pos_orders AS poc
         WHERE poc.vendor_id IN (2,3,5)  
         AND poc.order_type = 'sell'  
         AND DATE(poc.created_date) BETWEEN '2025-03-08' AND '2025-03-08'
        ) * 100), 2
    ) AS order_percentage
FROM  
    pos.pos_orders AS po  
JOIN  
    vendors AS v ON po.vendor_id = v.id  
WHERE  
    po.vendor_id IN (2,3,5)  
    AND po.order_type = 'sell'  
    AND po.brand_id = 14  
    --AND po.category_id = 14  
    AND DATE(po.created_date) BETWEEN '2025-03-09' AND '2025-03-09'  
GROUP BY  
    po.vendor_id;