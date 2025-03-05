SELECT  
    p.name AS product_name,  
    p.sku AS sku_code,  
    v.default_purchase_price,  
    v.default_sell_price,  
    CAST(SUM(vld.qty_available) AS UNSIGNED) AS current_stock  
FROM pos.products p  
JOIN pos.variations v ON p.id = v.product_id  
JOIN pos.variation_location_details vld ON v.id = vld.variation_id  
WHERE p.name LIKE '%mielle%'  
GROUP BY p.id, p.name, p.sku, v.default_purchase_price, v.default_sell_price  
HAVING current_stock > 0  
LIMIT 50000;
