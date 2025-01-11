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
      AND DATE(transaction_date) >= '2024-12-21'
      AND DATE(transaction_date) <= '2024-12-22'
)
SELECT 
    COALESCE(ROUND(total_order_amount / NULLIF(total_orders, 0), 2), 0) AS average_order_amount
FROM date_range;
