-------------------------------------------- Today's Sales ------------------------------------------

SELECT 
    COALESCE(ROUND(SUM(tsl.quantity)), 0) AS sales
FROM 
    pos.transaction_sell_lines AS tsl
JOIN pos.transactions ts ON tsl.transaction_id = ts.id
WHERE 
    tsl.product_id = 136
    AND (
        (ts.business_id = 1 
            AND ts.location_id = 1 
            AND ts.created_by = 1 
            AND ts.type = 'sell')
        OR 
        (ts.vendor_id IN (2,3,5))
    )
    AND DATE(tsl.created_at) BETWEEN '2025-02-01' AND '2025-02-27';
	

-------------------------------------------- Today's Sales Comparisions ------------------------------------------
SELECT
	new_sales.sales as new_sale,
	old_sales.sales as old_sale,
    COALESCE(ROUND(
        (new_sales.sales - old_sales.sales) / old_sales.sales * 100
    ), 0) AS sales_comparison_percentage
FROM
    (SELECT 
        COALESCE(ROUND(SUM(tsl.quantity)), 0) AS sales
    FROM 
        pos.transaction_sell_lines AS tsl
    JOIN pos.transactions ts ON tsl.transaction_id = ts.id
    WHERE 
        tsl.product_id = 136
        AND (
            (ts.business_id = 1 
                AND ts.location_id = 1 
                AND ts.created_by = 1 
                AND ts.type = 'sell')
            OR 
            (ts.vendor_id IN (2,3,5))
        )
        AND DATE(tsl.created_at) BETWEEN '2025-02-01' AND '2025-02-27') AS new_sales,
    
    (SELECT 
        COALESCE(ROUND(SUM(tsl.quantity)), 0) AS sales
    FROM 
        pos.transaction_sell_lines AS tsl
    JOIN pos.transactions ts ON tsl.transaction_id = ts.id
    WHERE 
        tsl.product_id = 136
        AND (
            (ts.business_id = 1 
                AND ts.location_id = 1 
                AND ts.created_by = 1 
                AND ts.type = 'sell')
            OR 
            (ts.vendor_id IN (2,3,5))
        )
        AND DATE(tsl.created_at) BETWEEN '2025-01-01' AND '2025-01-31') AS old_sales;

