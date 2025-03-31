/*RFM ANALYSIS
 * 
 * 
 * 
 * 
 * New Customers: 
 * Customers who have recently purchased (rfm_recency = 3), regardless of their frequency and spending.
Lost Customers: 
Customers who haven't purchased for a long time (rfm_recency = 1).
Regular Customers: 
Customers in the middle range of all three scores (rfm_recency = 2, rfm_frequency = 2, rfm_monetary = 2).
Loyal Customers: 
Customers who purchase frequently and spend a lot (rfm_frequency = 3 and rfm_monetary = 3).
Champion Customers: 
The best customers—recent, frequent, and high-spending (rfm_recency = 3, rfm_frequency = 3, and rfm_monetary = 3).
*/

with cust_cte as
(
select c.customer_id,
       max(o.order_date) as last_orderdate,
       count(o.order_id) as total_orders,
       SUM(oi.list_price * (1 - oi.discount) * oi.quantity) as spending,
       ('2019-01-01'::date-MAX(o.order_date)) AS days_since_last_order
 from orders o join order_items oi on o.order_id=oi.order_id
 join customers c on c.customer_id=o.customer_id 
 where o.order_status='4'
group by c.customer_id),
 rfm as 
   ( select *,
        ntile(3) over (order by days_since_last_order ) rfm_recency,
        ntile(3) over (order by total_orders) rfm_frequency,
        ntile(3) over (order by spending) rfm_monetary
 from cust_cte
 order by rfm_monetary desc)
 SELECT *,
       CASE 
           WHEN rfm_recency = 3 THEN 'New Customer'
           WHEN rfm_recency = 1 THEN 'Lost Customer'
           WHEN rfm_recency = 2 AND rfm_frequency = 2 AND rfm_monetary = 2 THEN 'Regular Customer'
           WHEN rfm_frequency = 3 AND rfm_monetary = 3 THEN 'Loyal Customer'
           WHEN rfm_recency = 3 AND rfm_frequency = 3 AND rfm_monetary = 3 THEN 'Champion Customer'
           ELSE 'Other'
       END AS customer_segment
FROM rfm
ORDER BY rfm_monetary DESC;
 
 






