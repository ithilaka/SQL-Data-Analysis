/*
===============================================================================
Date Range Exploration 
===============================================================================

*/

-- Determine the first and last order date and the total duration in months
SELECT 
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date,
    DATE_PART('month', AGE(MAX(order_date), MIN(order_date)))  AS order_range_months
FROM orders;

-- Determine the first and last shipped date and the total duration in months
SELECT 
    MIN(shipped_date) AS first_shipped_date,
    MAX(shipped_date) AS last_shipped_date,
    DATE_PART('month', AGE(MAX(shipped_date), MIN(shipped_date)))  AS order_range_months
FROM orders;

-----MIn Delivery time taken to deliver a product
--- order status --1: Pending, 2: Processing, 3: Rejected, 4: Completed

SELECT min(DATE_PART('day', AGE(shipped_date, order_date))) AS min_delivery_duration
FROM orders
WHERE order_status::INTEGER = 4;


---Average time taken by each store and count of orders for completed orders
SELECT store_id, 
       round(avg(shipped_date - order_date),2) AS avg_delivery_time,
       COUNT(order_id) AS total_orders
FROM orders
WHERE order_status = '4' 
GROUP BY store_id;


--------Order Status Distribution
select case when order_status='4' then 'completed'
            when order_status='3' then 'Rejected'
            when order_status='2' then 'Processing'
            when order_status='1' then 'Pending ' 
            else 'Unknown' end as status, 
            count(*) from orders 
 group by status