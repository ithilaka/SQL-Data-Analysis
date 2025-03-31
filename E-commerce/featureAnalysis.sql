
/*
===============================================================================
Feature Analysis
===============================================================================
Purpose:
    - To explore the structure of dimension tables.
	
SQL Functions Used:
    - DISTINCT
    - ORDER BY
===============================================================================
*/

-- Retrieve a list of unique city and state from which customers originate
select distinct city,state  from customers order by state;

-- Retrieve a list of 10  customer name
select first_name,last_name from customers order by last_name limit 10;

-- Retrieve a list of store name
select distinct store_name from stores;


-- Retrieve a list of brand names
select distinct brand_name from brands;


-- Retrieve a list of category names
select distinct category_name from categories;

-- Retrieve a list of product names 
select distinct product_name from products;

-- Customer Distribution -gives high density customer areas
select zip_code,state,city,count(*) from customers group by city,state,zip_code

