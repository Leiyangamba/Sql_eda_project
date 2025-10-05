-- measure exploration 
----------------------------------------------------------------------------------------------------------
-- find the total sale 
select sum(sales_amount) as total_sales from sales;
-- find how many item are sold
select sum(quantity) as item_sold from sales ;
-- find the avg selling price
select avg(price) as average from sales;
-- find the total no of product
select  count(distinct order_number) as total_product from sales;
-- find the total no of customers
select count( customer_key ) as couner from customers;
-- find the total no customers that has place an order 
select count(customer_key ) as couner from customers;
-- generate a report that shows all key metrics of the bussiness 
select 'total_sale' as measure_name ,sum(sales_amount) as measure_value from sales
union all
select 'total_quantity' as measure_name ,sum(quantity) as measure_value from sales
union all
select 'avg price', avg(price) as average from sales
union all
select  'total no. orders', count(distinct order_number) as total_product from sales
union all
select 'total number of product ',count( product_name  ) as couner from products
union all 
select'total no. of customers' ,count(customer_key ) as couner from customers
-- find the total sale 
select sum(sales_amount) as total_sales from sales
-- find how many item are sold
select sum(quantity) as item_sold from sales 
-- find the avg selling price
select avg(price) as average from sales
-- find the total no of product
select  count(distinct order_number) as total_product from sales
-- find the total no of customers
select count( customer_key ) as couner from customers
-- find the total no customers that has place an order 
select count(customer_key ) as couner from customers
-- generate a report that shows all key metrics of the bussiness 
select 'total_sale' as measure_name ,sum(sales_amount) as measure_value from sales
union all
select 'total_quantity' as measure_name ,sum(quantity) as measure_value from sales
union all
select 'avg price', avg(price) as average from sales
union all
select  'total no. orders', count(distinct order_number) as total_product from sales
union all
select 'total number of product ',count( product_name  ) as couner from products
union all 
select'total no. of customers' ,count(customer_key ) as couner from customers