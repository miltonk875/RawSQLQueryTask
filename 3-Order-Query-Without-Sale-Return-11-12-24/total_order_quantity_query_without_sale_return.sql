
-- Total Orders By Given Today Date
-- Default Type= sell, Other=
SELECT COUNT(*) AS today_orders FROM transactions WHERE type ='sell' AND DATE(transaction_date) = '2024-12-10' AND transactions.id NOT IN (SELECT return_parent_id FROM transactions WHERE return_parent_id IS NOT NULL);

-- Total Orders By Given Date (Yesterday)
SELECT COUNT(*) AS yesterday_orders FROM transactions WHERE type ='sell' AND DATE(transaction_date) = '2024-12-08' AND transactions.id NOT IN (SELECT return_parent_id FROM transactions WHERE return_parent_id IS NOT NULL);

-- Total Orders By This Week (From :last_seven_day to :yesterday)
SELECT COUNT(*) AS week_orders FROM transactions WHERE type ='sell' AND transaction_date BETWEEN '2024-12-02' AND '2024-12-08' AND transactions.id NOT IN (SELECT return_parent_id FROM transactions WHERE return_parent_id IS NOT NULL);

-- Total Orders By This Month (From :first_day_of_month to :to_month_date)
SELECT COUNT(*) AS month_orders FROM transactions WHERE type ='sell' AND transaction_date BETWEEN '2024-12-01' AND '2024-12-31' AND transactions.id NOT IN (SELECT return_parent_id FROM transactions WHERE return_parent_id IS NOT NULL);

-- Get Average Orders
SELECT ROUND(COUNT(*) / 7) AS average_orders FROM transactions WHERE type ='sell' AND transaction_date BETWEEN '2024-12-02' AND '2024-12-08' AND transactions.id NOT IN (SELECT return_parent_id FROM transactions WHERE return_parent_id IS NOT NULL);

-- Get Percentage Change for Today's Orders vs. Average Orders for the Week

SELECT 
    IFNULL(
        ROUND(
            (
                (SELECT COUNT(*) FROM transactions WHERE type ='sell' AND DATE(transaction_date) = '2024-12-09' AND transactions.id NOT IN (SELECT return_parent_id FROM transactions WHERE return_parent_id IS NOT NULL)) - 
                (SELECT COUNT(*) / 7 FROM transactions WHERE type ='sell' AND transaction_date BETWEEN '2024-12-02' AND '2024-12-08' AND transactions.id NOT IN (SELECT return_parent_id FROM transactions WHERE return_parent_id IS NOT NULL))
            ) / 
            (SELECT COUNT(*) / 7 FROM transactions WHERE type ='sell' AND transaction_date BETWEEN '2024-12-02' AND '2024-12-08' AND transactions.id NOT IN (SELECT return_parent_id FROM transactions WHERE return_parent_id IS NOT NULL)) * 100, 2
        ), 
    0) AS percentage_change;