/*
===============================================================================
 Product & Inventory Analysis
===============================================================================
Purpose:
    - To calculate best selling and least selling products


SQL Functions Used:
    - COUNT(), SUM(), AVG(),Join
===============================================================================
*/
------- TOP selling products
SELECT p.product_name, SUM(oi.quantity) AS total_sold
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC
LIMIT 10;

-----Stock turn over ratio
SELECT p.product_name, s.quantity AS stock_left, 
       SUM(oi.quantity) AS total_sold, 
       (SUM(oi.quantity) / NULLIF(s.quantity + SUM(oi.quantity), 0)) AS turnover_ratio
FROM products p
JOIN stocks s ON p.product_id = s.product_id
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_name, s.quantity
ORDER BY turnover_ratio DESC;

----Product trend over month and year
SELECT 
    p.product_id,
    p.product_name,
    EXTRACT(YEAR FROM o.order_date) AS year,
    EXTRACT(MONTH FROM o.order_date) AS month,
    SUM(oi.quantity) AS total_quantity_sold
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name, year, month
ORDER BY year, month, total_quantity_sold DESC;



