SELECT 
    COALESCE(
        ROUND(
            -- Percentage Change Formula: ((Avg1 - Avg2) / Avg2) * 100
            (
                -- Avg1
                (
                    SELECT 
                        COALESCE(ROUND(SUM(daily_avg) / COUNT(daily_avg), 2), 0)
                    FROM (
                        SELECT 
                            DATE(transaction_date) AS transaction_date,
                            SUM(final_total) / COUNT(*) AS daily_avg
                        FROM transactions
                        WHERE business_id = 1
                            AND location_id = 1
                            AND created_by = 1
                            AND type = 'sell'
							AND DATE(transaction_date) >= '2024-12-24'
                            AND DATE(transaction_date) <= '2024-12-25'
                        GROUP BY DATE(transaction_date)
                    ) AS daily_averages
                ) -
                -- Avg2
                (
                    SELECT 
                        COALESCE(ROUND(SUM(daily_avg) / COUNT(daily_avg), 2), 0)
                    FROM (
                        SELECT 
                            DATE(transaction_date) AS transaction_date,
                            SUM(final_total) / COUNT(*) AS daily_avg
                        FROM transactions
                        WHERE business_id = 1
                            AND location_id = 1
                            AND created_by = 1
                            AND type = 'sell'
                            AND DATE(transaction_date) >= '2024-12-22'
                            AND DATE(transaction_date) <= '2024-12-23'
                        GROUP BY DATE(transaction_date)
                    ) AS daily_averages
                )
            ) /
            -- Denominator: Avg2 (reference period)
            (
                SELECT 
                    COALESCE(ROUND(SUM(daily_avg) / COUNT(daily_avg), 2), 0)
                FROM (
                    SELECT 
                        DATE(transaction_date) AS transaction_date,
                        SUM(final_total) / COUNT(*) AS daily_avg
                    FROM transactions
                    WHERE business_id = 1
                        AND location_id = 1
                        AND created_by = 1
                        AND type = 'sell'
						AND DATE(transaction_date) >= '2024-12-22'
						AND DATE(transaction_date) <= '2024-12-23'
                    GROUP BY DATE(transaction_date)
                ) AS daily_averages
            ) * 100,
        2
    ),
    0
) AS comparisons_percentage;
