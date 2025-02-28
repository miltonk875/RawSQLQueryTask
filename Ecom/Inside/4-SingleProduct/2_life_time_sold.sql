-------------------------------------------- Product Life Time Sold  ------------------------------------------
SELECT 
    SUM(CASE WHEN source = 'business_location' THEN total_sold ELSE 0 END) AS sales_from_ecom,
    SUM(CASE WHEN source = 'other_markets' THEN total_sold ELSE 0 END) AS sales_from_other,
    SUM(total_sold) AS lifetime_sold
FROM (
    -- Sales from specific business and location
    SELECT 
        ROUND(SUM(COALESCE(tsl.quantity, 0))) AS total_sold,
        'business_location' AS source
    FROM 
        pos.transaction_sell_lines AS tsl
    JOIN pos.transactions ts ON tsl.transaction_id = ts.id
    WHERE 
        ts.business_id = 1 
        AND ts.location_id = 1 
        AND ts.created_by = 1 
        AND ts.type = 'sell' 
        AND tsl.product_id = 12
    
    UNION ALL

    -- Sales from other markets
    SELECT 
        ROUND(SUM(tsl.quantity)) AS total_sold,
        'other_markets' AS source
    FROM (
        SELECT DISTINCT vendor_id 
        FROM pos.transactions 
        WHERE vendor_id IN (2,3,5)
    ) v  
    LEFT JOIN pos.transactions t ON v.vendor_id = t.vendor_id  
    LEFT JOIN pos.transaction_sell_lines tsl ON t.id = tsl.transaction_id 
    WHERE tsl.product_id = 12  
    GROUP BY v.vendor_id
) subquery;
	

