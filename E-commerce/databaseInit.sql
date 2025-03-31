-- Create the 'DataAnalysis' database
CREATE DATABASE DataAnalysis;

CREATE SCHEMA sales;

drop table if exists customers;
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone VARCHAR(20),
    email VARCHAR(100),
    street VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code VARCHAR(20)
);
drop table if exists stores;
CREATE TABLE stores (
    store_id SERIAL PRIMARY KEY,
    store_name VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100),
    street VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code VARCHAR(20)
);

drop table if exists staffs;
CREATE TABLE staffs (
    staff_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    active BOOLEAN,
    store_id INT,
    manager_id INT,
    FOREIGN KEY (store_id) REFERENCES stores(store_id),
    FOREIGN KEY (manager_id) REFERENCES staffs(staff_id)
);

drop table if exists orders;
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    order_status VARCHAR(20),
    order_date DATE,
    required_date DATE,
    shipped_date DATE,
    store_id INT,
    staff_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (store_id) REFERENCES stores(store_id),
    FOREIGN KEY (staff_id) REFERENCES staffs(staff_id)
);

drop table if exists brands;
CREATE TABLE brands (
    brand_id SERIAL PRIMARY KEY,
    brand_name VARCHAR(100)
);

drop table if exists categories;
CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100)
);

drop table if exists products;
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    brand_id INT,
    category_id INT,
    model_year INT,
    list_price DECIMAL(10,2),
    FOREIGN KEY (brand_id) REFERENCES brands(brand_id),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

drop table if exists order_items;
CREATE TABLE order_items (
    order_id INT,
    item_id SERIAL,
    product_id INT,
    quantity INT,
    list_price DECIMAL(10,2),
    discount DECIMAL(5,2),
    PRIMARY KEY (order_id, item_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

drop table if exists stocks;
CREATE TABLE stocks (
    store_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (store_id, product_id),
    FOREIGN KEY (store_id) REFERENCES stores(store_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);



copy customers FROM 'C://Program Files//PostgreSQL//16//data//csv files//customers.csv' DELIMITER ',' CSV HEADER;

COPY stores FROM 'C://Program Files//PostgreSQL//16//data//csv files//stores.csv' DELIMITER ',' CSV HEADER;

COPY staffs FROM 'C://Program Files//PostgreSQL//16//data//csv files//staffs.csv' DELIMITER ',' CSV HEADER;

COPY orders FROM 'C://Program Files//PostgreSQL//16//data//csv files//orders.csv' DELIMITER ',' CSV header NULL 'NULL';

COPY brands FROM 'C://Program Files//PostgreSQL//16//data//csv files//brands.csv' DELIMITER ',' CSV HEADER;

COPY categories FROM 'C://Program Files//PostgreSQL//16//data//csv files//categories.csv' DELIMITER ',' CSV HEADER;

COPY products FROM 'C://Program Files//PostgreSQL//16//data//csv files// products.csv' DELIMITER ',' CSV HEADER;


COPY products FROM 'C:\\Program Files\\PostgreSQL\\16\\data\\csv files\\products.csv' 
DELIMITER ',' 
CSV HEADER;


COPY order_items FROM 'C://Program Files//PostgreSQL//16//data//csv files//order_items.csv' DELIMITER ',' CSV HEADER;

COPY stocks FROM 'C:\\Program Files\\PostgreSQL\\16\\data\\csv files\\stocks.csv' DELIMITER ',' CSV HEADER;




select * from customers

select * from stores;

SELECT column_name 
FROM information_schema.columns 
WHERE table_name = 'stores';

