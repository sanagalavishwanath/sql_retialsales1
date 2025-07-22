select * from retail_sales1
select count(*) from retail_sales1 limit 10

select * from retail_sales1
where transactions_id is null;


-- data cleaning
select * from retail_sales1
where sale_date is null;
select * from retail_sales1
where
transactions_id is null
OR
sale_date is null
OR
sale_time is null
OR
customer_id is null
OR 
gender is null
OR
category is null
OR
quantiy is null
OR
price_per_unit is null
OR
cogs is null
OR
total_sale is null;

delete from retail_sales1
where
transactions_id is null
OR
sale_date is null
OR
sale_time is null
OR
customer_id is null
OR 
gender is null
OR
category is null
OR
quantiy is null
OR
price_per_unit is null
OR
cogs is null
OR
total_sale is null;

-- data exloration

select count(*) as total_Sale from retail_sales1;

select count(distinct customer_id) as total_cutsomers from retail_sales1;

select distinct category from retail_sales1;

--data analysis & business key problems & sol
--Write a SQL query to retrieve all columns for sales made on '2022-11-05:
select * from retail_sales1 where sale_date = '2022-11-05';
--Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

select *
from retail_sales1 
where category = 'clothing'
and
TO_CHAR(sale_date,'YYYY-MM')='2022-11'
AND quantiy>=4;
--Write a SQL query to calculate the total sales (total_sale) for each category.:
select sum(total_sale),category from retail_sales1 group by category;
--Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
select ROUND(avg(age),2) as avgage from retail_sales1 where category = 'Beauty'
--Write a SQL query to find all transactions where the total_sale is greater than 1000.:
select * from retail_sales1 where total_sale>1000;
--Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:

select count(*),gender,category from retail_sales1 group by gender, category;
--Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
select * from(
select extract (year from sale_date) as year,
extract (month from sale_date) as month,
sum(total_sale) as totalsale,
rank() over (partition by extract(year from sale_date) order by avg(total_sale) desc)
from retail_sales1
group by 1,2
) as t1
where rank=1
--Write a SQL query to find the top 5 customers based on the highest total sales
select customer_id,sum(total_sale) from retail_sales1 
group by 1
order by 2 desc
limit 5;
--Write a SQL query to find the number of unique customers who purchased items from each category.:
select count(distinct(customer_id)),category from retail_sales1 group by category;
--Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
with hourly_sale as(
select *,
case
when extract (hour from sale_time) <12 then 'morning'
when extract (hour from sale_time) between 12 and 17 then 'evening'
else 'nigt'
end as shift
from retail_sales1
)
select shift,count(*) as total_orders
from hourly_sale
group by shift;

-- end of project
