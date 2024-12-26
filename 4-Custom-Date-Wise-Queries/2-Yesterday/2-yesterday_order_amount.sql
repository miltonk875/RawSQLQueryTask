
-- Orders Amount History By Today Date
SELECT 
        SUM(final_total) AS total_order_amount
        FROM transactions
        WHERE business_id = 1
          AND location_id = 1
          AND created_by = 1
          AND type = 'sell'
          AND DATE(transaction_date) >='2024-12-21'
          AND DATE(transaction_date) <= '2024-12-21';
		

-- Get Percentage Change for Today's Average Order
	WITH date_range AS (
            SELECT 
                SUM(final_total) AS total_order_amount,
                COUNT(*) AS total_orders
            FROM transactions
            WHERE business_id = 1
              AND location_id = 1
              AND created_by = 1
              AND type = 'sell'
              AND DATE(transaction_date) >= '2024-12-20'
              AND DATE(transaction_date) <= '2024-12-21'
        )
        SELECT 
            COALESCE(ROUND(total_order_amount / total_orders, 2), 0) AS average_order_amount
        FROM date_range;
		
	--- Get Comparison Percentage Change for Today's Order AMount
		
SELECT 
    COALESCE(
        ROUND(
            (
                -- Total amount for today's orders
                (SELECT SUM(final_total) 
                 FROM transactions 
                 WHERE business_id = 1 
                   AND location_id = 1 
                   AND created_by = 1 
                   AND type = 'sell' 
                   AND DATE(transaction_date) = '2024-12-21') - 
                 
                -- Average order amount for the previous days
                (SELECT COALESCE(
                    CAST(ROUND(SUM(final_total) / COUNT(*), 2) AS DECIMAL), 0) 
                 FROM transactions 
                 WHERE business_id = 1 
                   AND location_id = 1 
                   AND created_by = 1 
                   AND type = 'sell' 
                   AND DATE(transaction_date) BETWEEN '2024-12-20' AND '2024-12-20')
            ) / 
            -- Average order amount for the previous days
            (SELECT COALESCE(
                CAST(ROUND(SUM(final_total) / COUNT(*), 2) AS DECIMAL), 0) 
             FROM transactions 
             WHERE business_id = 1 
               AND location_id = 1 
               AND created_by = 1 
               AND type = 'sell' 
               AND DATE(transaction_date) BETWEEN '2024-12-20' AND '2024-12-20') * 100, 
        2
    ), 
    0) AS comparisons_percentage;
