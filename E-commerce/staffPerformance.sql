/*
===============================================================================
Staff Performance
===============================================================================
Purpose:
    - To calculate staff Efficiency


SQL Functions Used:
    - COUNT(), SUM(), AVG(),Join
===============================================================================
*/

-----Top Performing Staff (Sales Contribution per Staff)

SELECT 
    s.staff_id,
    s.first_name || ' ' || s.last_name AS staff_name,
    SUM(oi.quantity * (oi.list_price * (1 - oi.discount))) AS total_sales
FROM staffs s
JOIN orders o ON s.staff_id = o.staff_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY s.staff_id, staff_name
ORDER BY total_sales DESC;


-----Count of orders handled by staff
SELECT 
    s.staff_id,
    s.first_name || ' ' || s.last_name AS staff_name,
    COUNT(o.order_id) AS total_orders_handled
FROM staffs s
JOIN orders o ON s.staff_id = o.staff_id
GROUP BY s.staff_id, staff_name
ORDER BY total_orders_handled DESC;

----Sales Performance of Managers
SELECT 
    s.manager_id,
    m.first_name || ' ' || m.last_name AS manager_name,
    COUNT(s.staff_id) AS total_staff_managed,
    SUM(oi.quantity * (oi.list_price * (1 - oi.discount))) AS total_team_sales
FROM staffs s
JOIN staffs m ON s.manager_id = m.staff_id
JOIN orders o ON s.staff_id = o.staff_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY s.manager_id, manager_name
ORDER BY total_team_sales DESC;