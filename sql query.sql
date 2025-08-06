CREATE DATABASE sql_project_6;
USE sql_project_6;
SELECT * FROM pizza_sales;
DESCRIBE pizza_sales;
-- Need to rename the pizza column to fix the name
ALTER TABLE pizza_sales
RENAME COLUMN ï»¿pizza_id TO pizza_id;
-- Need to change order_date and order_time column type from text to date and time
UPDATE pizza_sales 
SET order_date = STR_TO_DATE(order_date , '%Y-%m-%d');
ALTER TABLE pizza_sales
MODIFY COLUMN order_date DATE;

UPDATE pizza_sales 
SET order_time = STR_TO_DATE(order_time , '%H:%i:%s');
ALTER TABLE pizza_sales
MODIFY COLUMN order_time TIME;

-- KPI Requirement
-- Total Revenue: The sum of total price of all pizza orders?
SELECT  SUM(total_price) AS total_revenue
FROM pizza_sales;
-- Average order value : 
SELECT COUNT(DISTINCT order_id) AS total_order , SUM(total_price) AS total_revenue , (SUM(total_price)/COUNT(DISTINCT order_id)) AS avg_order
FROM pizza_sales;
-- Total pizza sold: the sum off the quantity of all pizza sold 
SELECT SUM(quantity) AS total_pizza_sold
FROM pizza_sales;
-- Total orders: The total number of orders placed
SELECT COUNT(DISTINCT order_id)
FROM pizza_sales;
-- Average pizza per orders : 
SELECT SUM(quantity) AS total_pizza , COUNT(DISTINCT order_id) AS total_order , (SUM(quantity) / COUNT(DISTINCT order_id)) AS avg_pizza_order
FROM pizza_sales;

-- Part 2 Charts Requirement
-- Daily trend for orders
SELECT DAYNAME(order_date) AS day , COUNT(DISTINCT order_id) AS total_order
FROM pizza_sales
GROUP BY 1
ORDER BY 2 DESC;

-- Hourly trends for orders
SELECT HOUR(order_time) AS hourly , COUNT(DISTINCT order_id) AS total_order,
RANK() OVER(ORDER BY COUNT(DISTINCT order_id) DESC) AS Peak_hour_rank
FROM pizza_sales
GROUP BY 1
ORDER BY 1;

-- Perchentage of sales by pizza category
SELECT pizza_category ,
ROUND(SUM(total_price),2) AS total_revenues,
ROUND(SUM(total_price) *100 / SUM(SUM(total_price)) OVER(),2) AS per_sales_category
FROM  pizza_sales
GROUP BY 1; -- Can add filter for check for month or quarter percentage

-- Percentage of sales by pizza size 
SELECT pizza_size , 
ROUND(SUM(total_price)) AS total_sale ,
ROUND(SUM(total_price) *100 / SUM(SUM(total_price)) OVER(),2) AS per_sales_bysize
FROM pizza_sales
GROUP BY 1;

-- Top 5 best seller by total pizza sold
SELECT pizza_name , SUM(quantity) AS total_pizza_sold
FROM pizza_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- Bottom 5  by total pizza sold
SELECT pizza_name , SUM(quantity) AS total_pizza_sold
FROM pizza_sales
GROUP BY 1
ORDER BY 2 ASC
LIMIT 5;




























