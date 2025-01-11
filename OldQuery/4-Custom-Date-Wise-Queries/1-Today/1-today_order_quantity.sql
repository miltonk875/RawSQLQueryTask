
-- Orders History By Today Date

SELECT COUNT(*) AS orders
FROM transactions
WHERE business_id = 1
  AND location_id = 1
  AND created_by = 1
  AND type = 'sell'
  AND DATE(transaction_date) BETWEEN '2024-12-12' AND '2024-12-12';
		

-- Average Orders History By Today Date
SELECT COALESCE(CAST(ROUND(AVG(order_counts)) AS SIGNED), 0) AS average_orders
FROM (
    SELECT 
        DATE(transaction_date) AS transaction_date, 
        COUNT(DISTINCT id) AS order_counts
    FROM transactions
    WHERE business_id = 1
	  AND location_id = 1
	  AND created_by = 1
	  AND type = 'sell'
	  AND DATE(transaction_date) BETWEEN '2024-12-11' AND '2024-12-12'
    GROUP BY DATE(transaction_date)
) AS daily_orders;

-- Get Percentage Change for Today's Orders vs. Average Orders for the Week
SELECT 
    COALESCE(
        ROUND(
            (
			-- Total count for yesterday
                (SELECT COUNT(*) 
                 FROM transactions 
                 WHERE business_id = 1 
                   AND location_id = 1 
                   AND created_by = 1 
                   AND type = 'sell' 
                   AND DATE(transaction_date) = '2024-12-11') - 
				   -- Half the average count over the previous days
                (SELECT COALESCE(
                    CAST(ROUND(COUNT(*) / 2) AS UNSIGNED), 0) 
                 FROM transactions 
                 WHERE business_id = 1 
                   AND location_id = 1 
                   AND created_by = 1 
                   AND type = 'sell' 
                   AND DATE(transaction_date) BETWEEN '2024-12-10' AND '2024-12-11')
            ) / 
			   -- Half the average count over the previous days
            (SELECT COALESCE(
                CAST(ROUND(COUNT(*) / 2) AS UNSIGNED), 0) 
             FROM transactions 
             WHERE business_id = 1 
               AND location_id = 1 
               AND created_by = 1 
               AND type = 'sell' 
               AND DATE(transaction_date) BETWEEN '2024-12-10' AND '2024-12-11') * 100, 
        2
    ), 
    0) AS comparisons_percentage;
