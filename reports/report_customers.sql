/*
========================================================================================================================== 
  customers report
 ===========================================================================================
 purpose :
  - this report consolidate key customer metrics and behaviors
 highlight :
   1. gathers essential fields such as names , ages, and transaction details
   2. segments customers into categories (VIP,regular,new) and age groups.
   3. Aggregates customer level metrics
    - total orders
    - total sales 
    - total quantity purchased 
    - total products 
    - lifespan(in months)
   4 calculate valuable KPIs;
    - recency (month since last order)
    -average order values
    -average monthly spend
 ======================================================== */
 create view report_customers as
 -- 1 . base query ; retriving core column from tables
 with base_query as
 ( select s.order_number,s.product_key,s.order_date,s.sales_amount,s.quantity,
 c.customer_key,c.customer_number,c.first_name,c.birthdate,
 concat(c.first_name, ' ' ,c.last_name) as full_name,
 timestampdiff(year,c.birthdate,now()) as age
 from sales s
 left join customers c 
 on s.customer_key = c.customer_key
 left join products p
 on s.product_key = p.product_key
 where order_date is not null)
 
 , customer_aggregations as(
 
 -- 2. customer aggregation : summarizes key metrics at the customer level
 -- =========================================================================================
 select customer_key,
 customer_number,
 full_name,
 age,
 count(distinct order_number ) as total_orders,
 sum(sales_amount) as total_sales,
 count( distinct product_key) as total_products,
 max(order_date) as last_order_date,
 timestampdiff(month,min(order_date),max(order_date))as lifespan
 from base_query
 group by  customer_key,
 customer_number,
 full_name,
 age)
 
 select customer_key,customer_number, full_name,age,
 case when age <20 then 'under 20'
 when age between 20 and 29 then '20-29'
  when age between 30 and 39 then '30-39'
   when age between 40 and 49 then '40-49'
   else '50 above'
   end as age_group ,
 case 
 when lifespan >=12 and total_sales > 5000 then 'vip'
 when lifespan >=12 and total_sales <= 5000 then 'regular'
 else 'new'
 end as customer_segement,
 last_order_date,
 timestampdiff(month,last_order_date,now()) as recency,
 
  total_orders,
 total_sales,
 total_products,
 lifespan,
 -- compute average order value (AVO)
 case when total_sales =0 then 0
else  total_sales /total_orders 
end as avg_order_value,
-- compute average monthly spend 
case when lifespan = 0 then total_sales
else total_sales/ lifespan
end as avg_monthly_span
 from customer_aggregations