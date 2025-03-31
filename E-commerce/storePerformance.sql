/*
===============================================================================
Store Performance
===============================================================================
Purpose:
    - To calculate Store Performance


SQL Functions Used:
    - COUNT(), SUM(), AVG(),Join
===============================================================================
*/

------Revenue Per store
select s.store_id,s.store_name as store,
         SUM(oi.list_price * (1 - oi.discount) * oi.quantity) AS store_sales
from stores s join orders o
on s.store_id=o.store_id
join order_items oi on oi.order_id=o.order_id
group by s.store_id, store
order by store_sales desc;


-----No of  unique Customers per store
select s.store_id,s.store_name as store,
        COUNT(distinct c.customer_id) AS store_customers
from stores s join orders o on o.store_id=s.store_id 
join customers c on c.customer_id=o.customer_id
group by s.store_id,store
order by store_customers desc;

-----store with quickest delivery time

SELECT store_id, 
       MIN(shipped_date - order_date) AS min_delivery_time,
       COUNT(order_id) AS total_orders
FROM orders
WHERE order_status = '4'  -- Assuming order_status is stored as VARCHAR
GROUP BY store_id
ORDER BY min_delivery_time ASC
LIMIT 1;

-----Average Delivery Time 
select AVG(shipped_date - order_date) from orders;

-----Order Cancellation Rate
SELECT 
    COUNT(CASE WHEN order_status = '3' THEN 1 END) * 100.0 / COUNT(*) AS cancellation_rate
FROM orders;

-------On-time Delivery Rate
SELECT 
    COUNT(CASE WHEN shipped_date <= required_date THEN 1 END) * 100.0 / COUNT(*) AS ontime_delivery_rate
FROM orders;


