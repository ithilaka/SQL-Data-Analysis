/*
===============================================================================
Customer Analysis
===============================================================================
Purpose:
    - To calculate customer spending ,Freuent customer


SQL Functions Used:
    - COUNT(), SUM(), AVG(),Join
===============================================================================
*/

-------Frequent Customer
select c.customer_id,c.first_name,c.last_name,
       count(o.order_id) as count_of_orders from 
customers c join orders o on o.customer_id=c.customer_id 
group by c.customer_id,c.first_name,c.last_name
order by count_of_orders desc;


-------Top 10 customers generating highest revenue
select   c.customer_id,c.first_name,c.last_name,
       SUM(oi.list_price * (1 - oi.discount) * oi.quantity) AS customer_spending
from customers c join orders o
on c.customer_id=o.customer_id
join order_items oi on oi.order_id=o.order_id where o.order_status='4'
group by  c.customer_id,c.first_name,c.last_name
order by customer_spending desc limit 10;

-------New Vs Repeat Customers
select customer, count(customer_id)  from
(SELECT 
    customer_id, 
    MAX(customer_type) as customer
FROM
 (select o.customer_id,o.order_date,
    CASE WHEN first_purchase.max_date = first_purchase.min_date THEN 'New' ELSE 'Repeat' END AS customer_type
  FROM orders o INNER JOIN (
   SELECT customer_id, MIN(order_date) AS min_date,max(order_date) as max_date FROM orders 
   GROUP BY customer_id) AS first_purchase ON o.customer_id = first_purchase.customer_id
ORDER BY o.customer_id, o.order_date) AS customer_classification
GROUP BY customer_id) as customer_classify group by customer;












