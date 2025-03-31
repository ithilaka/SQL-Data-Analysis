/*
===============================================================================
year over year Performance Analysis
===============================================================================
Purpose:
    - To Compare Year over Year Performance Analysis


SQL Functions Used:
    - Extract, SUM(), Lead(),Join
===============================================================================
*/

SELECT 
    EXTRACT(YEAR FROM o.order_date) AS year,
    SUM(oi.list_price * (1 - oi.discount) * oi.quantity) AS total_sales,---total sales
    LAG(SUM(oi.list_price * (1 - oi.discount) * oi.quantity)) OVER (ORDER BY EXTRACT(YEAR FROM o.order_date)) AS previous_year_sales,
    ROUND(
        (SUM(oi.list_price * (1 - oi.discount) * oi.quantity) - 
        LAG(SUM(oi.list_price * (1 - oi.discount) * oi.quantity)) OVER (ORDER BY EXTRACT(YEAR FROM o.order_date))) 
        / NULLIF(LAG(SUM(oi.list_price * (1 - oi.discount) * oi.quantity)) OVER (ORDER BY EXTRACT(YEAR FROM o.order_date)), 0) * 100, 2
    ) AS yoy_growth_percentage,
    CASE 
        WHEN (SUM(oi.list_price * (1 - oi.discount) * oi.quantity) - 
              LAG(SUM(oi.list_price * (1 - oi.discount) * oi.quantity)) OVER (ORDER BY EXTRACT(YEAR FROM o.order_date))) > 0 
        THEN 'Increase' 
        ELSE 'Decrease' 
    END AS sales_trend
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY year
ORDER BY year;