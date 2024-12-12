
-- Total Orders By Given Today Date
-- Default Type= sell, Other=
SELECT COUNT(*) AS today_orders FROM transactions WHERE type ='sell' AND DATE(transaction_date) = '2024-12-10';

-- Total Orders By Given Date (Yesterday)
SELECT COUNT(*) AS yesterday_orders FROM transactions WHERE type ='sell' AND DATE(transaction_date) = '2024-12-08';

-- Total Orders By This Week (From :last_seven_day to :yesterday)
SELECT COUNT(*) AS week_orders FROM transactions WHERE type ='sell' AND transaction_date BETWEEN '2024-12-02' AND '2024-12-08';

-- Total Orders By This Month (From :first_day_of_month to :to_month_date)
SELECT COUNT(*) AS month_orders FROM transactions WHERE type ='sell' AND transaction_date BETWEEN '2024-12-01' AND '2024-12-31';

-- Get Average Orders
SELECT ROUND(COUNT(*) / 7) AS average_orders FROM transactions WHERE type ='sell' AND transaction_date BETWEEN '2024-12-02' AND '2024-12-08';

-- Get Percentage Change for Today's Orders vs. Average Orders for the Week

SELECT 
    IFNULL(
        ROUND(
            (
                (SELECT COUNT(*) FROM transactions WHERE type ='sell' AND DATE(transaction_date) = '2024-12-09') - 
                (SELECT COUNT(*) / 7 FROM transactions WHERE type ='sell' AND transaction_date BETWEEN '2024-12-02' AND '2024-12-08')
            ) / 
            (SELECT COUNT(*) / 7 FROM transactions WHERE type ='sell' AND transaction_date BETWEEN '2024-12-02' AND '2024-12-08') * 100, 2
        ), 
    0) AS percentage_change;