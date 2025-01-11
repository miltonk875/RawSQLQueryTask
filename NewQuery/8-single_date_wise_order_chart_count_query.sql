WITH time_ranges AS (
    SELECT '12 AM - 2:59 AM' AS time_range, '00:00' AS start_time, '02:59' AS end_time
    UNION ALL SELECT '3 AM - 5:59 AM', '03:00', '05:59'
    UNION ALL SELECT '6 AM - 8:59 AM', '06:00', '08:59'
    UNION ALL SELECT '9 AM - 11:59 AM', '09:00', '11:59'
    UNION ALL SELECT '12 PM - 2:59 PM', '12:00', '14:59'
    UNION ALL SELECT '3 PM - 5:59 PM', '15:00', '17:59'
    UNION ALL SELECT '6 PM - 8:59 PM', '18:00', '20:59'
    UNION ALL SELECT '9 PM - 11:59 PM', '21:00', '23:59'
)
SELECT 
    time_ranges.time_range,
    COUNT(*) AS total_order_count
FROM time_ranges

LEFT JOIN order_details od
    ON TIME(od.created_at) >= time_ranges.start_time
    AND TIME(od.created_at) <= time_ranges.end_time
    AND DATE(od.created_at) >= '2025-01-10'
    AND DATE(od.created_at) <= '2025-01-10'

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
