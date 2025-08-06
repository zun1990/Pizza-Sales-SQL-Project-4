# Pizza-Sales-SQL-Project-4
### Pizza Sales Analysis on SQL & TABLEAU
### Database: sql_project_6

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore and analyze sales data. The project contains performing exploratory data analysis (EDA), and answering specific business related questions through SQL queries .Using TABLEAU we will shows the visualization of the insights. 

## Objectives

1. **Set up a Pizza sales database**: Populate the database with the provided sales data.
2. **Data Cleaning**: Data CLeaning by changing column type and rename column .
3. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.
4. **Visualization**: Using Tableau we will derive the insights of the sales data into visualization

## CRUD Operation
```sql
-- Need to rename the pizza column to fix the name
ALTER TABLE pizza_sales
RENAME COLUMN ï»¿pizza_id TO pizza_id;
```
```sql
-- Need to change order_date and order_time column type from text to date and time
UPDATE pizza_sales 
SET order_date = STR_TO_DATE(order_date , '%Y-%m-%d');
ALTER TABLE pizza_sales
MODIFY COLUMN order_date DATE;

UPDATE pizza_sales 
SET order_time = STR_TO_DATE(order_time , '%H:%i:%s');
ALTER TABLE pizza_sales
MODIFY COLUMN order_time TIME;
```

## Data Manipulation or Data Analysis:
```sql
-- KPI Requirement
-- Total Revenue: The sum of total price of all pizza orders?
SELECT  SUM(total_price) AS total_revenue
FROM pizza_sales;
```
```sql
-- Average order value : 
SELECT COUNT(DISTINCT order_id) AS total_order , SUM(total_price) AS total_revenue , (SUM(total_price)/COUNT(DISTINCT order_id)) AS avg_order
FROM pizza_sales;
```
```sql
-- Total pizza sold: the sum off the quantity of all pizza sold 
SELECT SUM(quantity) AS total_pizza_sold
FROM pizza_sales;
```
```sql
-- Total orders: The total number of orders placed
SELECT COUNT(DISTINCT order_id)
FROM pizza_sales;
```
```sql
-- Average pizza per orders : 
SELECT SUM(quantity) AS total_pizza , COUNT(DISTINCT order_id) AS total_order , (SUM(quantity) / COUNT(DISTINCT order_id)) AS avg_pizza_order
FROM pizza_sales;
```
```sql
-- Daily trend for orders
SELECT DAYNAME(order_date) AS day , COUNT(DISTINCT order_id) AS total_order
FROM pizza_sales
GROUP BY 1
ORDER BY 2 DESC;
```
```sql
-- Hourly trends for orders
SELECT HOUR(order_time) AS hourly , COUNT(DISTINCT order_id) AS total_order,
RANK() OVER(ORDER BY COUNT(DISTINCT order_id) DESC) AS Peak_hour_rank
FROM pizza_sales
GROUP BY 1
ORDER BY 1;
```
```sql
-- Perchentage of sales by pizza category
SELECT pizza_category ,
ROUND(SUM(total_price),2) AS total_revenues,
ROUND(SUM(total_price) *100 / SUM(SUM(total_price)) OVER(),2) AS per_sales_category
FROM  pizza_sales
GROUP BY 1; -- Can add filter for check for month or quarter percentage
```
```sql
-- Percentage of sales by pizza size 
SELECT pizza_size , 
ROUND(SUM(total_price)) AS total_sale ,
ROUND(SUM(total_price) *100 / SUM(SUM(total_price)) OVER(),2) AS per_sales_bysize
FROM pizza_sales
GROUP BY 1;
```
```sql
-- Top 5 best seller by total pizza sold
SELECT pizza_name , SUM(quantity) AS total_pizza_sold
FROM pizza_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
```
```sql
-- Bottom 5  by total pizza sold
SELECT pizza_name , SUM(quantity) AS total_pizza_sold
FROM pizza_sales
GROUP BY 1
ORDER BY 2 ASC
LIMIT 5;
```

## Visualization
We derive the finding from the analysis and we will make it visualize through Tableau and find the top bullet point from the visualization.

https://public.tableau.com/views/Dashboad_17544769019400/PizzaSalesDasboard?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link

