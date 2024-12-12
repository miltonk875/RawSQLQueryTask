
-- Total amounts By Given Today Date
-- Default Type= sell
SELECT SUM(final_total) AS today_amounts FROM transactions WHERE type ='sell' AND DATE(transaction_date) = '2024-12-10';

-- Total amounts By Given Date (Yesterday)
SELECT SUM(final_total) AS yesterday_amounts FROM transactions WHERE type ='sell' AND DATE(transaction_date) = '2024-12-10';

-- Total amounts By This Week (From :last_seven_day to :yesterday)
SELECT SUM(final_total) AS week_amounts FROM transactions WHERE type ='sell' AND transaction_date BETWEEN '2024-12-03' AND '2024-12-10';

-- Total amounts By This Month (From :first_day_of_month to :to_month_date)
SELECT SUM(final_total) AS month_amounts FROM transactions WHERE type ='sell' AND transaction_date BETWEEN '2024-12-01' AND '2024-12-31';

-- Get Average amounts
SELECT ROUND(SUM(final_total) / 7) AS average_amounts FROM transactions WHERE type ='sell' AND transaction_date BETWEEN '2024-12-03' AND '2024-12-10';

-- Get Percentage Change for Today's amounts vs. Average amounts for the Week

SELECT 
    IFNULL(
        ROUND(
            (
                (SELECT SUM(final_total) FROM transactions WHERE type ='sell' AND DATE(transaction_date) = '2024-12-09') - 
                (SELECT SUM(final_total) / 7 FROM transactions WHERE type ='sell' AND transaction_date BETWEEN '2024-12-03' AND '2024-12-10')
            ) / 
            (SELECT SUM(final_total) / 7 FROM transactions WHERE type ='sell' AND transaction_date BETWEEN '2024-12-03' AND '2024-12-10') * 100, 2
        ), 
    0) AS percentage_change;