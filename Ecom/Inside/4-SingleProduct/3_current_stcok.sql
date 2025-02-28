---------------------------------------------------- Current Stock From POS DB * ------------------------------------------
SELECT 
    CAST(SUM(vld.qty_available) AS UNSIGNED) AS current_stock
FROM 
    pos.variation_location_details AS vld
JOIN 
    pos.products AS p ON p.id = vld.product_id
WHERE 
    vld.product_id = 13;