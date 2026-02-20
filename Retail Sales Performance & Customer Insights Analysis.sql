select top 2 * from trans

1. select * from trans 
where sale_date = '2022-11-05'

2. select * from trans 
where category = 'clothing' 
and sale_date >= '2022-11-01' and sale_date < '2022-12-01'
and quantiy >= 4

3. select category, sum(total_sale) as total_sales_by_category from trans
group by category

4. select avg(age) as avg_age_beauty_custom from trans 
where category = 'beauty'

5. select * from trans 
where total_sale > 1000

6. select gender, count(distinct transactions_id) as total_transactions
from trans
group by gender
order by total_transactions desc

7. SELECT TOP 1 WITH TIES
    DATEPART(YEAR, sale_date) AS year,
    DATEPART(MONTH, sale_date) AS month,
    AVG(total_sale) AS avg_sale
FROM trans
GROUP BY DATEPART(YEAR, sale_date), DATEPART(MONTH, sale_date)
ORDER BY ROW_NUMBER() OVER (
PARTITION BY DATEPART(YEAR, sale_date)
    ORDER BY AVG(total_sale) DESC
);   

8. select top 5 customer_id, sum(total_sale) as total_saled_by_customer from  trans
group by customer_id
order by total_saled_by_customer desc

9. select category, count(distinct customer_id) as
no_of_customers from trans
group by category

10. SELECT 
    shift,
    COUNT(*) AS total_orders
FROM (
    SELECT *,
        CASE
            WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
            WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM trans
) AS shifted_sales
GROUP BY shift;   

10. method 2

with hourly_sale
as 
(
select *,
case
 when datepart(hour, sale_time) < 12 then 'morning'
 when datepart(hour, sale_time) between 12 and 17 then 'afternoon'
 else 'evening'
end as shift_time from trans
)
select
SHIFT_time,
COUNT(*) AS TOTAL_ORDERS
FROM hourly_sale
GROUP BY shift_time
