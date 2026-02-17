# SQL Retail Sales Analysis Project

A comprehensive data analysis of retail sales transactions using SQL. This project covers data cleaning, exploration, and business insights through 10 key analytical questions.

## 📊 Project Overview
- **Dataset**: Retail sales transactions
- **Tools**: SQL Server (SSMS)
- **Analysis Focus**: Sales trends, customer behavior, category performance, and time-based patterns

## 🧩 Key Questions & Insights
1. Sales on `2022-11-05`

   select * from trans
where sale_date = '2022-11-05'

2. High-quantity clothing sales in Nov 2022
   
select * from trans 
where category = 'clothing' 
and sale_date >= '2022-11-01' and sale_date < '2022-12-01'
and quantiy >= 4

3. Total sales by category
   
select category, sum(total_sale) as total_sales_by_category from trans
group by category

4. Average age of Beauty customers
   
select avg(age) as avg_age_beauty_custom from trans 
where category = 'beauty'

5. High-value transactions (> $1000)
    
select * from trans 
where total_sale > 1000

6. Transactions by gender and category
    
select gender, count(distinct transactions_id) as total_transactions
from trans
group by gender
order by total_transactions desc

7. Best-selling month per year
    
SELECT TOP 1 WITH TIES
    DATEPART(YEAR, sale_date) AS year,
    DATEPART(MONTH, sale_date) AS month,
    AVG(total_sale) AS avg_sale
FROM trans
GROUP BY DATEPART(YEAR, sale_date), DATEPART(MONTH, sale_date)
ORDER BY ROW_NUMBER() OVER (
PARTITION BY DATEPART(YEAR, sale_date)
    ORDER BY AVG(total_sale) DESC
);   

8. Top 5 customers by total spending
   
select top 5 customer_id, sum(total_sale) as total_saled_by_customer from  trans
group by customer_id
order by total_saled_by_customer desc

10. Unique customers per category
    
select category, count(distinct customer_id) as
no_of_customers from trans
group by category

11. Order volume by time of day (Morning/Afternoon/Evening)
    
SELECT 
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

method 2

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


## 🛠️ Technical Implementation
- **Data Cleaning**: Removed rows with NULL values in critical fields
- **Date Handling**: Used `DATEPART()` for year/month extraction
- **Ranking**: `ROW_NUMBER()` with `PARTITION BY` to find top months
- **Time-Based Shifts**: Categorized sales into Morning, Afternoon, Evening using `CASE` and `DATEPART(HOUR, ...)`

## 📁 Files Included
- `schema.sql` - Database and table creation
- `data_cleaning.sql` - NULL handling and validation
- `analysis.sql` - All 10 business queries
- `readme.md` - This file

## 🔗 Connect With Me
[www.linkedin.com/in/ayomide-rotimi-1ba9261bb] | [Coming] | [Rotimiayomide99@yahoo.com]

---

*Built with SQL Server
