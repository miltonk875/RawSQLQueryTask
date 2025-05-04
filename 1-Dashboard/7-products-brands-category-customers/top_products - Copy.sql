SELECT 
    p.id,
    p.name,
    ROUND(SUM(vld.qty_available)) AS stock,
    br.name AS brand,
    IFNULL(cs.current_sale, 0) AS current_sale,
    IFNULL(ps.previous_sale, 0) AS previous_sale,
    IFNULL(ecom.ecom_orders, 0) AS ecom_orders,
    IFNULL(market.market_orders, 0) AS market_orders,
    (IFNULL(ecom.ecom_orders, 0) + IFNULL(market.market_orders, 0)) AS total_orders,
    ROUND(
        CASE 
            WHEN IFNULL(ps.previous_sale, 0) = 0 THEN 0
            ELSE (IFNULL(cs.current_sale, 0) - IFNULL(ps.previous_sale, 0)) / IFNULL(ps.previous_sale, 1) * 100
        END, 2
    ) AS trend,
    p.unit_price,
    IFNULL(ts.total_sold, 0) AS sales
FROM bbbd_ecommerce_test.products AS p

-- Brand info
LEFT JOIN bbbd_ecommerce_test.brands AS br ON p.brand_id = br.id

-- Stock
LEFT JOIN pos.variation_location_details AS vld ON p.id = vld.product_id AND vld.location_id = 1

-- Current sale
LEFT JOIN (
    SELECT od.product_id, ROUND(SUM(od.quantity)) AS current_sale
    FROM bbbd_ecommerce_test.order_details AS od
    WHERE od.created_at BETWEEN '2025-04-29 00:00:00' AND '2025-04-29 23:59:59'
    GROUP BY od.product_id
) AS cs ON p.id = cs.product_id

-- Previous sale
LEFT JOIN (
    SELECT od.product_id, ROUND(SUM(od.quantity)) AS previous_sale
    FROM bbbd_ecommerce_test.order_details AS od
    WHERE od.created_at BETWEEN '2025-04-28 00:00:00' AND '2025-04-28 23:59:59'
    GROUP BY od.product_id
) AS ps ON p.id = ps.product_id

-- Total sold
LEFT JOIN (
    SELECT od.product_id, ROUND(SUM(od.quantity)) AS total_sold
    FROM bbbd_ecommerce_test.order_details AS od
    GROUP BY od.product_id
) AS ts ON p.id = ts.product_id

-- E-commerce orders on date
LEFT JOIN (
    SELECT od.product_id, SUM(od.quantity) AS ecom_orders
    FROM bbbd_ecommerce_test.order_details AS od
    WHERE od.created_at BETWEEN '2025-04-29 00:00:00' AND '2025-04-29 23:59:59'
    GROUP BY od.product_id
) AS ecom ON p.id = ecom.product_id

-- Market orders on date
LEFT JOIN (
    SELECT tsl.product_id, ROUND(SUM(tsl.quantity)) AS market_orders
    FROM pos.transaction_sell_lines AS tsl
    JOIN pos.transactions AS ts ON ts.id = tsl.transaction_id
    WHERE 
        ts.vendor_id IN (2,3,5)
        AND ts.type = 'sell'
        AND ts.created_at BETWEEN '2025-04-29 00:00:00' AND '2025-04-29 23:59:59'
    GROUP BY tsl.product_id
) AS market ON p.id = market.product_id

GROUP BY p.id
HAVING current_sale > 0
ORDER BY current_sale DESC;
