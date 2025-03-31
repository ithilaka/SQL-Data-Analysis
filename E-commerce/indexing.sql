
/*
 * *********************************************************************************************************
 * OPTIMIZING AND INDEXING
 * ******************************************************************************************************
 */
-----Shows the execution plan without running the query
EXPLAIN SELECT * FROM orders;

------- Runs the query and provides actual execution time.
EXPLAIN ANALYZE SELECT * FROM customers;

-----Checking Join Performance
EXPLAIN ANALYZE 
SELECT c.customer_id, o.order_id
FROM customers c 
JOIN orders o ON c.customer_id = o.customer_id;

-- Creating an index with the freuently used column for search
CREATE INDEX idx_orders_order_date ON orders (order_date);

-- Creating a partitioned table
CREATE TABLE orders (
  order_id INT PRIMARY KEY,
  order_date DATE NOT NULL,
  customer_id INT NOT NULL
) PARTITION BY RANGE (YEAR(order_date)) (
PARTITION orders_2022 VALUES LESS THAN (2023),
PARTITION orders_2023 VALUES LESS THAN (2024),
PARTITION orders_future VALUES LESS THAN MAXVALUE
);


