 -------------------------------------- All Average Order-------------------------------------

SELECT 
    ROUND(
        ( 
            (SELECT ROUND(SUM(o.grand_total), 0)
             FROM bbbd_ecommerce_test.orders AS o
             ) 
            + 
            (SELECT ROUND(SUM(ts.final_total), 0) 
             FROM pos.transactions ts
             WHERE vendor_id IN (2,3,5) AND type = 'sell'
             ) 
        ) / 2
    ) AS average_order_value;
	
-------------------------------------- Date Wise Average Order-------------------------------------

SELECT 
    ROUND(
        ( 
            (SELECT ROUND(SUM(o.grand_total), 0)
             FROM bbbd_ecommerce_test.orders AS o
             WHERE DATE(o.created_at) >= '2025-05-10'
			 AND DATE(o.created_at) <= '2025-05-10'
             ) 
            + 
            (SELECT ROUND(SUM(ts.final_total), 0)
             FROM pos.transactions ts
             WHERE vendor_id IN (2,3,5) AND type = 'sell' 
             AND DATE(ts.created_at) >= '2025-05-10'
			 AND DATE(ts.created_at) <= '2025-05-10'
             ) 
        ) / 2
    ) AS average_order_value;