/******************************** In Stock Products ***************************/

SELECT 
    CAST(SUM(vld.qty_available) AS UNSIGNED) AS current_stock
FROM 
    pos.variation_location_details AS vld
JOIN 
    pos.products AS p ON p.id = vld.product_id


/******************************** Out Stock Products ***************************/

SELECT COUNT(*) AS out_stock
FROM (
    SELECT 
        p.id AS product_id,
        SUM(vld.qty_available) AS out_stock
    FROM 
        pos.variation_location_details AS vld
    JOIN 
        pos.products AS p ON p.id = vld.product_id
    GROUP BY 
        p.id
    HAVING 
        SUM(vld.qty_available) = 0
) AS sub;
