-------------------------------------------- Total Ecom Sold ------------------------------------------
SELECT 
	FORMAT(COALESCE(SUM(tsl.quantity), 0), 0) AS total_sold
FROM
    pos.transaction_sell_lines AS tsl
JOIN 
    pos.transactions ts ON tsl.transaction_id = ts.id
WHERE 
	ts.vendor_id IN (2,3,5)
    AND tsl.product_id = 136
    AND DATE(ts.created_at) BETWEEN '2025-02-25' AND '2025-02-28';
	
	
-------------------------------------------- Total Ecom Sold As Comparisions------------------------------------------
SELECT 
    FORMAT(COALESCE(new.total_new_sold, 0), 0) AS new_sales,
    FORMAT(COALESCE(old.total_old_sold, 0), 0) AS old_sales,
    COALESCE(
        ROUND(
            ((COALESCE(new.total_new_sold, 0) - COALESCE(old.total_old_sold, 0)) / 
            NULLIF(COALESCE(old.total_old_sold, 0), 0)) * 100, 
            2
        ), 0
    ) AS sale_comparisons
FROM 
    (
        -- New sales by current date range
        SELECT 
            COALESCE(SUM(tsl.quantity), 0) AS total_new_sold
        FROM
            pos.transaction_sell_lines AS tsl
        JOIN 
            pos.transactions ts ON tsl.transaction_id = ts.id
        WHERE 
			ts.vendor_id IN (2,3,5)
			AND tsl.product_id = 136
            AND DATE(ts.created_at) BETWEEN '2025-02-25' AND '2025-02-28'
    ) AS new,
    (
        -- Old sales by old date range
        SELECT 
            COALESCE(SUM(tsl.quantity), 0) AS total_old_sold
        FROM
            pos.transaction_sell_lines AS tsl
        JOIN 
            pos.transactions ts ON tsl.transaction_id = ts.id
        WHERE 
			ts.vendor_id IN (2,3,5)
			AND tsl.product_id = 136
            AND DATE(ts.created_at) BETWEEN '2025-02-21' AND '2025-02-24'
    ) AS old;