-------------------------------------------- Product Details Query From Ecom DB ------------------------------------------
SELECT 
    p.id AS product_id,
    p.name AS product_name,
    CONCAT('https://beautyboothqa.com/product/', p.slug) AS product_link,
    u.file_name AS file_name,
    p.brand_id AS brand_id,
    b.name AS brand_name,
    p.category_id AS category_id,
    c.name AS category_name
FROM 
    products AS p
LEFT JOIN 
    uploads AS u ON p.thumbnail_img = u.id
LEFT JOIN 
    brands AS b ON p.brand_id = b.id
LEFT JOIN 
    categories AS c ON p.category_id = c.id
WHERE 
    p.id = 136;
	
-------------------------------------------- Product Life Time Sold  ------------------------------------------
SELECT 
    COUNT(quantity) as life_time_sold
FROM 
    order_details AS od
WHERE 
    od.product_id = 136;
-------------------------------------------- Current Stock From POS DB * ------------------------------------------
SELECT 
    ROUND(SUM(vld.qty_available)) AS stock
FROM qatar_pos_db.products AS p
JOIN qatar_pos_db.variation_location_details AS vld ON p.id = vld.product_id
WHERE 
	p.id=12
 AND
    vld.location_id = 1;
-------------------------------------------- Current Stock's Sale Status From POS DB * ------------------------------------------
SELECT 
    ROUND(SUM(tsl.quantity)) AS sale_summary
FROM qatar_pos_db.transaction_sell_lines AS tsl
JOIN qatar_pos_db.transactions AS t ON tsl.transaction_id = t.id
WHERE 
	tsl.product_id=12
 AND
    t.location_id = 1;
 AND t.type ='sell';

-------------------------------------------- Current Stock's Purchase Status From POS DB * ------------------------------------------
SELECT 
    ROUND(SUM(tsl.quantity)) AS purchase_summary
FROM pos.transaction_sell_lines AS tsl
JOIN pos.transactions AS t ON tsl.transaction_id = t.id
JOIN pos.purchase_lines AS pl ON tsl.id = pl.transaction_id
WHERE 
	tsl.product_id=12
 AND
    t.location_id = 1;
 AND t.type ='purchase';
 
 
SELECT 
    t.id AS transaction_id,
    t.type AS transaction_type,
    sl.quantity AS sell_line_quantity,
    pl.quantity AS purchase_line_quantity,
    rsl.quantity_returned AS sell_return,
    rpl.quantity_returned AS purchase_return,
    al.quantity AS stock_adjusted,
    pl.quantity_returned AS combined_purchase_return,
    t.return_parent_id,
    t.transaction_date,
    t.status,
    t.invoice_no,
    t.ref_no
FROM transactions t
LEFT JOIN transaction_sell_lines sl ON sl.transaction_id = t.id
LEFT JOIN purchase_lines pl ON pl.transaction_id = t.id
LEFT JOIN stock_adjustment_lines al ON al.transaction_id = t.id
LEFT JOIN transactions `return` ON t.return_parent_id = `return`.id
LEFT JOIN purchase_lines rpl ON rpl.transaction_id = `return`.id
LEFT JOIN transaction_sell_lines rsl ON rsl.transaction_id = `return`.id
WHERE t.location_id = 1 