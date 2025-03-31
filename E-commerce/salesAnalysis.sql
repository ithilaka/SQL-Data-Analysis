/*
===============================================================================
Sales Analysis
===============================================================================
Purpose:
    - To calculate sales analysis with respect to product,brand


SQL Functions Used:
    - COUNT(), SUM(), AVG()
===============================================================================
*/

------Selling Price per Order item
SELECT 
    oi.order_id,
    oi.product_id,
    p.product_name,
    oi.quantity,
    oi.list_price,
    oi.discount,
    (oi.list_price * (1 - oi.discount)) AS selling_price_per_unit,
    (oi.list_price * (1 - oi.discount) * oi.quantity) AS total_selling_price
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
ORDER BY oi.order_id;


---Total revenue per product
SELECT 
    oi.product_id,
    p.product_name,
    SUM(oi.list_price * (1 - oi.discount) * oi.quantity) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY oi.product_id, p.product_name
ORDER BY total_revenue DESC;


--------Weekly Sales Trend
SELECT 
    o.order_date, 
    round(SUM(list_price * (1 - discount) * quantity),2) AS daily_sales
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY order_date
ORDER BY order_date;




--------Monthly Sales Trend

SELECT 
    DATE_PART('year', o.order_date) AS year,
    TO_CHAR(o.order_date, 'Month') AS month,
    SUM(oi.list_price * (1 - oi.discount) * oi.quantity) AS monthly_sales
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY year, month
ORDER BY year, month;


-----------WeeKday Vs WeeKend Sales Analysis
select (case when extract(dow from order_date) in (0,6) then 'weekend'else 'weekday' end) as day_type,
SUM(oi.list_price * (1 - oi.discount) * oi.quantity) AS total_sales
from  orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY  day_type
ORDER BY total_sales desc;

-----Category wise Sales Distribution
select c.category_name as category, 
       SUM(oi.list_price * (1 - oi.discount) * oi.quantity) AS category_sales
from products p join
order_items oi on oi.product_id=p.product_id
join categories c on  p.category_id=c.category_id
group by category
order by category_sales desc;


--------Brand Wise Sales
select b.brand_name as brand, 
       SUM(oi.list_price * (1 - oi.discount) * oi.quantity) AS brand_sales
from products p join
order_items oi on oi.product_id=p.product_id
join brands b on  p.brand_id=b.brand_id
group by brand
order by brand_sales desc;


-- Calculate the total sales per month 
-- and the running total of sales over time 
SELECT
    order_date,
    total_sales,
    SUM(total_sales) OVER (ORDER BY order_date) AS running_total_sales,
    AVG(avg_price) OVER (ORDER BY order_date) AS moving_average_price
FROM
(
    SELECT 
        DATE_PART('year', o.order_date) AS order_date,
        SUM(oi.list_price * (1 - oi.discount) * oi.quantity) AS total_sales,
        AVG(oi.list_price) AS avg_price
    FROM orders o 
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_date IS NOT NULL
    GROUP BY DATE_PART('year', o.order_date)
) AS yearly_sales;


