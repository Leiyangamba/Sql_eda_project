-- Ranking Analysis
------------------------------------------------------------------
-- which 5 products generate the highest revenue?

select p.product_name,sum(s.sales_amount) as total_paisa
from products p left join sales s
on p.product_key = s.product_key
group by p.product_name
order by total_paisa desc
limit 5 ;
-- window function method
select *
from(
select p.product_name,sum(s.sales_amount) as total_paisa,
row_number() over( order by sum(s.sales_amount) desc) rankingALL
from products p left join sales s
on p.product_key = s.product_key
group by p.product_name) t
where rankingALL <= 5;
-- what are the 5 worst -performnce products in term of sales?
select p.product_name,sum(s.sales_amount) as total_paisa
from products p left join sales s
on p.product_key = s.product_key
group by p.product_name
order by total_paisa 
limit 5

-- window methods 

select *
from(
select p.product_name,sum(s.sales_amount) as total_paisa,
row_number() over( order by sum(s.sales_amount) desc) rankingALL
from products p left join sales s
on p.product_key = s.product_key
group by p.product_name) t
where rankingALL >= 5;

-- find the top 10 customers who have generate the highest revenue and 
select c.customer_key, c.first_name,sum(s.sales_amount) as total_paisa
from customers c left join sales s
on c.customer_key = s.customer_key
group by c.customer_key,c.first_name
order by total_paisa desc
limit 10 
;
-- the 3 customers with the fewest orders place
select c.customer_key, c.first_name,count(s.order_number) as total_order
from sales s left join customers c
on c.customer_key = s.customer_key
group by c.customer_key,c.first_name
order by total_order asc
limit 3
