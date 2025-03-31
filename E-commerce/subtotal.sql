/* TO FIND the store Performance sales of each store for all years and months */



SELECT 
    s.store_name,
    COALESCE(TO_CHAR(o.order_date, 'YYYY'), 'Grand Total') AS year,  
    COALESCE(TO_CHAR(o.order_date, 'MM'), 'Subtotal') AS month,  
    SUM(oi.list_price * (1 - oi.discount) * oi.quantity) AS total_sales
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
join stores s on s.store_id=o.store_id
GROUP BY ROLLUP (s.store_name,TO_CHAR(o.order_date, 'YYYY'), TO_CHAR(o.order_date, 'MM'))
ORDER BY s.store_name,year, month;