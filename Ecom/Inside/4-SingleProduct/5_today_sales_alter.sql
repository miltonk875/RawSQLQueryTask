-------------------------------------------- Today's Sales ------------------------------------------
--Demo 1
SELECT 
	COALESCE(
		ROUND(SUM(tsl.quantity)), 0
    ) AS sales
FROM 
    pos.transaction_sell_lines AS tsl
JOIN pos.transactions ts ON tsl.transaction_id = ts.id
WHERE 
    ts.business_id = 1 
    AND ts.location_id = 1 
    AND ts.created_by = 1 
    AND ts.type = 'sell' 
    AND tsl.product_id = 136
    AND DATE(tsl.created_at) BETWEEN '2025-02-01' AND '2025-02-27'
--Demo 2
SELECT 
	COALESCE(
		ROUND(SUM(tsl.quantity)), 0
    ) AS sales
FROM 
    pos.transaction_sell_lines AS tsl
JOIN pos.transactions ts ON tsl.transaction_id = ts.id
WHERE ts.vendor_id IN (2,3,5)
    AND tsl.product_id = 136
    AND DATE(tsl.created_at) BETWEEN '2025-02-01' AND '2025-02-27'
	
----Demo 3
SELECT 
    COALESCE(
		ROUND(SUM(CASE 
        WHEN ts.business_id = 1 
            AND ts.location_id = 1 
            AND ts.created_by = 1 
            AND ts.type = 'sell' 
            AND tsl.product_id = 136 
        THEN tsl.quantity 
        ELSE 0 
    END)), 0
	) AS ecom_sales,
    
    COALESCE(
		ROUND(SUM(CASE 
        WHEN ts.vendor_id IN (2,3,5) 
            AND tsl.product_id = 136 
        THEN tsl.quantity 
        ELSE 0 
    END)), 0
	) AS market_sales,

    COALESCE(
		ROUND(SUM(CASE 
        WHEN (ts.business_id = 1 
                AND ts.location_id = 1 
                AND ts.created_by = 1 
                AND ts.type = 'sell' 
                AND tsl.product_id = 136)
            OR 
            (ts.vendor_id IN (2,3,5) 
                AND tsl.product_id = 136) 
        THEN tsl.quantity 
        ELSE 0 
    END)), 0
	) AS total_sales
FROM 
    pos.transaction_sell_lines AS tsl
JOIN pos.transactions ts ON tsl.transaction_id = ts.id
WHERE 
    tsl.product_id = 136
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

