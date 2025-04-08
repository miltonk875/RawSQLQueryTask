-------------------------------------------- Product Prices ------------------------------------------
SELECT 
	COALESCE(SUM(unit_price), 0) AS price
FROM 
	bbbd_ecommerce_test.products
WHERE 
	id = 14
	
-------------------------------------------- Product Sale Prices ------------------------------------------
SELECT 
    FORMAT(
        IFNULL(
            CASE 
                WHEN discount_end_date > UNIX_TIMESTAMP() AND discount_start_date <= UNIX_TIMESTAMP() THEN 
                    CASE 
                        WHEN discount_type = 'percent' THEN unit_price - (unit_price * (discount / 100))
                        ELSE unit_price - discount
                    END
                ELSE unit_price
            END, 0
        ), 2
    ) AS sale_price
FROM bbbd_ecommerce_test.products
WHERE id = 14
AND DATE(updated_at) ='2025-02-05';