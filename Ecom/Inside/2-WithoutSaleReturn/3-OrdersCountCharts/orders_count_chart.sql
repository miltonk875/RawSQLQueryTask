------------------------------ Single Date Wise Order Count-------------------------------
SELECT 
    time_ranges.time_range,
    COUNT(*) AS total_order_count
FROM 
    (SELECT '12 AM - 2:59 AM' AS time_range, '00:00' AS start_time, '02:59' AS end_time
     UNION ALL SELECT '3 AM - 5:59 AM', '03:00', '05:59'
     UNION ALL SELECT '6 AM - 8:59 AM', '06:00', '08:59'
     UNION ALL SELECT '9 AM - 11:59 AM', '09:00', '11:59'
     UNION ALL SELECT '12 PM - 2:59 PM', '12:00', '14:59'
     UNION ALL SELECT '3 PM - 5:59 PM', '15:00', '17:59'
     UNION ALL SELECT '6 PM - 8:59 PM', '18:00', '20:59'
     UNION ALL SELECT '9 PM - 11:59 PM', '21:00', '23:59') AS time_ranges
LEFT JOIN bbbd_ecommerce_test.orders o
    ON TIME(o.created_at) >= time_ranges.start_time
    AND TIME(o.created_at) <= time_ranges.end_time
    AND DATE(o.created_at) = '2025-02-10'
	AND o.delivery_status='cancelled'
GROUP BY time_ranges.time_range
ORDER BY FIELD(time_ranges.time_range, 
    '12 AM - 2:59 AM',
    '3 AM - 5:59 AM',
    '6 AM - 8:59 AM',
    '9 AM - 11:59 AM',
    '12 PM - 2:59 PM',
    '3 PM - 5:59 PM',
    '6 PM - 8:59 PM',
    '9 PM - 11:59 PM');
	
------------------------------ Date Wise Order Count-------------------------------
SELECT 
    DATE(o.created_at) AS order_date,
    COUNT(*) AS total_order
FROM 
    bbbd_ecommerce_test.orders o
WHERE 
    DATE(o.created_at) >= '2025-02-01' 
    AND DATE(o.created_at) <= '2025-02-08'
	AND o.delivery_status='cancelled'
GROUP BY 
    DATE(o.created_at)
