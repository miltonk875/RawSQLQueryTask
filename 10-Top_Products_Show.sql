SELECT 
    p.id AS product_id, 
    p.name AS product_name, 
    ROUND(vld.qty_available) AS current_stock, 
    ROUND(SUM(tsl.quantity)) AS total_sale, 
    ROUND(SUM(tsl.quantity * tsl.unit_price_inc_tax), 2) AS total_sale_amount,
    CASE 
        WHEN SUM(tsl.quantity) > 0 THEN 
            ROUND((SUM(tsl.quantity) - LAG(SUM(tsl.quantity)) OVER (ORDER BY SUM(tsl.quantity) DESC)) 
                  / LAG(SUM(tsl.quantity)) OVER (ORDER BY SUM(tsl.quantity) DESC) * 100, 2)
        ELSE 0
    END AS sale_comparison
FROM 
    products p
LEFT JOIN 
    variation_location_details vld ON p.id = vld.product_id
LEFT JOIN 
    transaction_sell_lines tsl ON p.id = tsl.product_id
WHERE 
    p.business_id = 1 
    AND vld.location_id = 1 
    AND DATE(tsl.created_at) >= '2024-08-20' 
    AND DATE(tsl.created_at) <= '2024-09-31'
GROUP BY 
    vld.product_id, tsl.product_id, p.id, p.name
ORDER BY 
    total_sale DESC, p.id DESC
LIMIT 1000;
