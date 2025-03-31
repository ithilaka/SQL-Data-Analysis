/*
===============================================================================
Discount Analysis
===============================================================================
Purpose:
    - To calculate best selling and leasy selling products


SQL Functions Used:
    - COUNT(), SUM(), AVG(),Join
===============================================================================
*/

---Impact of discount on sales
SELECT 
    CASE 
        WHEN discount > 0 THEN 'Discounted Sales'
        ELSE 'Non-Discounted Sales'
    END AS sale_type,
    SUM(quantity * (list_price * (1 - discount))) AS total_revenue,
    COUNT(*) AS total_orders
FROM order_items
GROUP BY sale_type;

-----Average Discount given per order
SELECT 
    o.order_id,
    ROUND(AVG(discount) * 100, 2) AS avg_discount_percentage
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
GROUP BY o.order_id
ORDER BY avg_discount_percentage DESC;

----