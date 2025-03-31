/*
===============================================================================
KPI Analysis
===============================================================================
Purpose:
    - To calculate aggregated metrics (e.g., totals, averages) for quick insights.


SQL Functions Used:
    - COUNT(), SUM(), AVG()
===============================================================================
*/


-- Find the Total orders
select count( distinct order_id) from orders;


----Find the Total customers
select count( customer_id) from customers;


----Find the Total products
select count(distinct product_id) from products;


---Find the Total brands
select count(distinct brand_id) from brands;


---Find the Total categories
select count(distinct category_id) from categories;


-- Find how many items are sold
select sum(quantity)  AS total_quantity from order_items;

-- Find the average selling price
select round(avg((list_price*(1-discount))*quantity),2) from order_items;


---Find the Average Order Value
select round(AVG(list_price * quantity),2) from order_items;

----Find the Total Revenue
select round(sum((list_price*(1-discount))*quantity),2) from order_items;

-- Generate a Report that shows all key metrics of the business
SELECT 'Total Sales' AS kpi_name, round(sum((list_price*(1-discount))*quantity),2) AS kpi_value FROM order_items
UNION ALL
SELECT 'Total Quantity', SUM(quantity) AS kpi_value  FROM order_items
UNION ALL
SELECT 'Average Price', round(AVG(list_price * quantity),2) AS kpi_value  from order_items
UNION ALL
SELECT 'Total Orders', count( distinct order_id) AS kpi_value from orders
UNION ALL
SELECT 'Total Products', count(distinct product_id) from products
UNION ALL
SELECT 'Total Customers',count( customer_id) from customers;

