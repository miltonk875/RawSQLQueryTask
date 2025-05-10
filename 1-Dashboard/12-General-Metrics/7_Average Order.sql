 -------------------------------------- All Average Order-------------------------------------

SELECT 
    ROUND(
        ( 
            (SELECT COUNT(*) 
             FROM bbbd_ecommerce_test.orders AS o
             ) 
            + 
            (SELECT COUNT(*) 
             FROM pos.transactions ts
             WHERE vendor_id IN (2,3,5) AND type = 'sell'
             ) 
        ) / 2
    ) AS average_orders;
	
-------------------------------------- Date Wise Average Order-------------------------------------

SELECT 
    ROUND(
        ( 
            (SELECT COUNT(*) 
             FROM bbbd_ecommerce_test.orders AS o
             WHERE DATE(o.created_at) >= '2025-05-10'
			 AND DATE(o.created_at) <= '2025-05-10'
             ) 
            + 
            (SELECT COUNT(*) 
             FROM pos.transactions ts
             WHERE vendor_id IN (2,3,5) AND type = 'sell' 
             AND DATE(ts.created_at) >= '2025-05-10'
			 AND DATE(ts.created_at) <= '2025-05-10'
             ) 
        ) / 2
    ) AS average_orders;