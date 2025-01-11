

--Average Order Amount By Date Wise
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
		
	--- Get Comparison Percentage for Today's Average Order Amount
		
SELECT 
    COALESCE(
        ROUND(
            (
                (SELECT COALESCE(ROUND(SUM(final_total) / NULLIF(COUNT(*), 0), 2), 0)
                 FROM transactions 
                 WHERE business_id = 1 
                   AND location_id = 1 
                   AND created_by = 1 
                   AND type = 'sell' 
                   AND DATE(transaction_date) BETWEEN '2024-12-21' AND '2024-12-22'
                ) 
                - 
                (SELECT COALESCE(ROUND(SUM(final_total) / NULLIF(COUNT(*), 0), 2), 0)
                 FROM transactions 
                 WHERE business_id = 1 
                   AND location_id = 1 
                   AND created_by = 1 
                   AND type = 'sell' 
                   AND DATE(transaction_date) BETWEEN '2024-12-19' AND '2024-12-20'
                )
            ) 
            / 
            NULLIF(
                (SELECT COALESCE(ROUND(SUM(final_total) / NULLIF(COUNT(*), 0), 2), 0)
                 FROM transactions 
                 WHERE business_id = 1 
                   AND location_id = 1 
                   AND created_by = 1 
                   AND type = 'sell' 
                   AND DATE(transaction_date) BETWEEN '2024-12-19' AND '2024-12-20'
                ), 
                0
            ) * 100, 
        2
    ), 
    0
) AS comparisons_percentage;


