SELECT 
    p.id,
    p.name,
    SUM(vld.qty_available) AS stock,
    br.name AS brand,
    -- Sales data from derived table
    IFNULL(sales.current_sale, 0) AS current_sale,
    IFNULL(sales.previous_sale, 0) AS previous_sale,
    IFNULL(ecom.ecom_orders, 0) AS ecom_orders,
     CAST(IFNULL(market.market_orders, 0) AS UNSIGNED) AS market_orders,
    CAST(IFNULL(ecom.ecom_orders, 0) + IFNULL(market.market_orders, 0) AS UNSIGNED) AS total_orders,
    -- Trend calculation
    ROUND(
        CASE 
            WHEN IFNULL(sales.previous_sale, 0) = 0 THEN 0
            ELSE (IFNULL(sales.current_sale, 0) - IFNULL(sales.previous_sale, 0)) / IFNULL(sales.previous_sale, 1) * 100
        END, 2
    ) AS trend,

    p.unit_price,
    IFNULL(sales.total_sold, 0) AS sales

FROM bbbd_ecommerce_test.products AS p

-- Brand info
LEFT JOIN bbbd_ecommerce_test.brands AS br ON p.brand_id = br.id

-- Stock
LEFT JOIN pos.variation_location_details AS vld 
    ON p.id = vld.product_id AND vld.location_id = 1

-- Combined Sales Data (Current, Previous, Total Sold)
LEFT JOIN (
    SELECT 
        od.product_id,
        SUM(CASE 
            WHEN od.created_at >= '2025-05-03 00:00:00' AND od.created_at < '2025-05-04 00:00:00' 
            THEN od.quantity ELSE 0 
        END) AS current_sale,
        SUM(CASE 
            WHEN od.created_at >= '2025-05-02 00:00:00' AND od.created_at < '2025-05-03 00:00:00' 
            THEN od.quantity ELSE 0 
        END) AS previous_sale,
        SUM(CASE 
            WHEN od.created_at >= '2025-05-03 00:00:00' AND od.created_at < '2025-05-04 00:00:00' 
            THEN od.quantity ELSE 0 
        END) AS total_sold
    FROM bbbd_ecommerce_test.order_details AS od
    GROUP BY od.product_id
) AS sales ON p.id = sales.product_id

-- E-commerce orders
LEFT JOIN (
    SELECT 
        od.product_id, 
        SUM(od.quantity) AS ecom_orders
    FROM bbbd_ecommerce_test.order_details AS od
    WHERE od.created_at >= '2025-05-03 00:00:00' AND od.created_at < '2025-05-04 00:00:00'
    GROUP BY od.product_id
) AS ecom ON p.id = ecom.product_id

-- Market orders
LEFT JOIN (
    SELECT 
        tsl.product_id, 
        SUM(tsl.quantity) AS market_orders
    FROM pos.transaction_sell_lines AS tsl
    INNER JOIN pos.transactions AS ts 
        ON ts.id = tsl.transaction_id
    WHERE 
        ts.vendor_id IN (2, 3, 5)
        AND ts.type = 'sell'
        AND tsl.created_at >= '2025-05-03 00:00:00' AND tsl.created_at < '2025-05-04 00:00:00'
    GROUP BY tsl.product_id
) AS market ON p.id = market.product_id

GROUP BY p.id
HAVING current_sale > 0
ORDER BY current_sale DESC;