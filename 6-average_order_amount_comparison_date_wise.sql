SELECT 
    COALESCE(
        ROUND(
            -- Average order amount for 2024-12-20
            (
                SELECT 
                    COALESCE(ROUND(SUM(daily_avg) / COUNT(daily_avg), 2), 0) AS total_average_order_amount
                FROM (
                    SELECT 
                        DATE(transaction_date) AS transaction_date,
                        SUM(final_total) / COUNT(*) AS daily_avg
                    FROM transactions
                    WHERE business_id = 1
                        AND location_id = 1
                        AND created_by = 1
                        AND type = 'sell'
                        AND DATE(transaction_date) >= '2024-12-16'
                        AND DATE(transaction_date) <= '2024-12-20'
                    GROUP BY DATE(transaction_date)
                ) AS daily_averages
            ) /
            -- Total average order amount for entire period
            (
                SELECT 
                    COALESCE(ROUND(SUM(daily_avg) / COUNT(daily_avg), 2), 0) AS total_average_order_amount
                FROM (
                    SELECT 
                        DATE(transaction_date) AS transaction_date,
                        SUM(final_total) / COUNT(*) AS daily_avg
                    FROM transactions
                    WHERE business_id = 1
                        AND location_id = 1
                        AND created_by = 1
                        AND type = 'sell'
                        AND DATE(transaction_date) >= '2024-12-01'
                        AND DATE(transaction_date) <= '2024-12-20'
                    GROUP BY DATE(transaction_date)
                ) AS daily_averages
            ) * 100,
            2
        ),
        0
    ) AS comparisons_percentage;
