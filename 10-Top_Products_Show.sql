SELECT 
    p.id AS product_id, 
    p.name AS product_name, 
    ROUND(vld.qty_available) AS current_stock, 
    ROUND(total_sale.total_sale) AS total_sale, 
    ROUND(total_sale.total_sale_amount, 2) AS total_sale_amount,
    CASE 
        WHEN total_sale.total_sale > 0 THEN 
            ROUND((total_sale.total_sale - LAG(total_sale.total_sale) OVER (ORDER BY total_sale.total_sale DESC)) 
                  / LAG(total_sale.total_sale) OVER (ORDER BY total_sale.total_sale DESC) * 100, 2)
        ELSE 0
    END AS sale_comparison
FROM 
    products p
LEFT JOIN 
    variation_location_details vld ON p.id = vld.product_id
LEFT JOIN 
    ( 
        SELECT 
            tsl.product_id, 
            SUM(tsl.quantity) AS total_sale, 
            SUM(tsl.quantity * tsl.unit_price_inc_tax) AS total_sale_amount
        FROM 
            transaction_sell_lines tsl
        WHERE 
            DATE(tsl.created_at) >= '2024-08-20' 
            AND DATE(tsl.created_at) <= '2024-09-31'
        GROUP BY 
            tsl.product_id
    ) AS total_sale ON p.id = total_sale.product_id
WHERE 
    p.business_id = 1 
    AND vld.location_id = 1
GROUP BY 
    p.id, p.name, vld.qty_available, total_sale.total_sale, total_sale.total_sale_amount
ORDER BY 
    total_sale.total_sale DESC, p.id DESC
LIMIT 1000;
