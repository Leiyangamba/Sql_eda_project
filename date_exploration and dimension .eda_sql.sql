
-- date Exploration
-----------------------
-- explore all the country our customers come from
SELECT distinct country FROM customers;
-- explore all categories "the major divisions"
select distinct category
from products;

-- find the date of the first and last order
select min(str_to_date(order_date, '%d-%m-%y'))as first_order,
max(str_to_date(order_date, '%d-%m-%y')) as last_date,
datediff(min(str_to_date(order_date, '%d-%m-%y')),
max(str_to_date(order_date, '%d-%m-%y'))) as actual
from sales

-- find youngest and olderst customer
select min(birthdate)as first_order,
min(birthdate)as last_date
from customers