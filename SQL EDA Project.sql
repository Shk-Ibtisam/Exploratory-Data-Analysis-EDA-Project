SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'gold.dim_customers'

--Dimensions Exploration--

USE DataWarehouseAnalytics

--Explore All Countries our Customers come from.

SELECT DISTINCT country FROM gold.dim_customers

--Explore all Categories  "Major Divisions"

SELECT DISTINCT category , subcategory , product_name FROM gold.dim_products
ORDER BY 1,2,3

--Date Exploration--

--Find the date of first and last order .  
--How many years of sales ?

SELECT
MIN(order_date) AS first_order_date,
MAX(order_date) AS last_order_date,
DATEDIFF(year , MIN(order_date) , MAX(order_date)) AS order_range 
FROM gold.fact_sales

--Find the customers with minimum and maximum birthdate. 

SELECT 
MIN(birthdate) AS oldest_birthdate,
DATEDIFF(year , MIN(birthdate) , GETDATE()) AS oldest_age,
MAX(birthdate) AS maximum_birthdate,
DATEDIFF(year , MAX(birthdate) , GETDATE()) AS youngest_age,
DATEDIFF(year , MIN(birthdate) , MAX(birthdate)) AS difference_in_age
FROM gold.dim_customers

--Measures Exploration--

-- Find the total sales 
SELECT SUM(sales_amount) AS total_sales FROM gold.fact_sales

--How many items are sold 
SELECT SUM(quantity) AS total_quantity FROM gold.fact_sales

--Average selling price 
SELECT AVG(price) AS average_price FROM gold.fact_sales

--Total number of orders 
SELECT COUNT(DISTINCT order_number) AS Total_orders FROM gold.fact_sales

--Total number of products 
SELECT COUNT(DISTINCT product_key) AS Total_products FROM gold.dim_products

--Total number of customers (Overall)
SELECT COUNT(customer_key) AS total_customers FROM gold.dim_customers

--Total number of customers that place an order
SELECT COUNT(DISTINCT customer_key) AS total_customers FROM gold.fact_sales



--Generate a report that shows all key metrics of the buisness

SELECT 'Total Sale' as measure_name , SUM(sales_amount) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Quantity' , SUM(quantity) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Average Price' , AVG(price) AS average_price FROM gold.fact_sales
UNION ALL
SELECT 'Total Orders' , COUNT(DISTINCT order_number) AS Total_orders FROM gold.fact_sales
UNION ALL
SELECT  'Total Products' , COUNT(DISTINCT product_key) AS Total_products FROM gold.dim_products
UNION ALL
SELECT 'Total Customers' , COUNT(customer_key) AS total_customers FROM gold.dim_customers



--Magnitude Analysis of the data Measures By Dimensions--

--Find Total customers by countries
SELECT country,COUNT(customer_key) AS total_customers 
FROM gold.dim_customers
GROUP BY country 
ORDER BY total_customers DESC

--Find Total Customers By Gender
SELECT gender,COUNT(customer_key) AS total_customers 
FROM gold.dim_customers
GROUP BY gender 
ORDER BY total_customers DESC

--Find Total Products BY Category
SELECT category , COUNT(product_key) AS total_products
FROM gold.dim_products
GROUP BY category
ORDER BY total_products DESC

--What is Average Cost in each Category  
SELECT category , AVG(cost) AS Average_cost
FROM gold.dim_products
GROUP BY category
ORDER BY Average_cost DESC

--What is the Total Revenue for each Category ? 
SELECT 
p.category , 
SUM(f.sales_amount) total_revenue 
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p 
ON p.product_key = f.product_key
GROUP BY p.category
ORDER BY total_revenue DESC

--What is the Total Revenue from each customer ?
SELECT DISTINCT
c.customer_key,
c.first_name,
c.last_name,
SUM(f.sales_amount) total_revenue
FROM gold.fact_sales f
LEFT JOIN  gold.dim_customers c
ON c.customer_key = f.customer_key
GROUP BY
c.customer_key,
c.first_name,
c.last_name
ORDER BY total_revenue DESC


--What is the distribution of sold items across countries ?
SELECT 
c.country,
SUM(f.quantity) total_sold_items
FROM gold.fact_sales f
LEFT JOIN  gold.dim_customers c
ON c.customer_key = f.customer_key
GROUP BY c.country
ORDER BY total_sold_items DESC


--Ranking Analysis--

--Which products generate the highest revenue ?
SELECT TOP 5
p.product_name , 
SUM(f.sales_amount) total_revenue 
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p 
ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC


--Which are the 5 worst performing products ?
SELECT TOP 5
p.product_name , 
SUM(f.sales_amount) total_revenue 
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p 
ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue 

--Find Top 10 Customers who have generated the highest revenue
SELECT DISTINCT TOP 10
c.customer_key,
c.first_name,
c.last_name,
SUM(f.sales_amount) total_revenue
FROM gold.fact_sales f
LEFT JOIN  gold.dim_customers c
ON c.customer_key = f.customer_key
GROUP BY
c.customer_key,
c.first_name,
c.last_name
ORDER BY total_revenue DESC

--Top 3 Customers with the fewest order placed 
SELECT TOP 3
c.customer_key,
c.first_name,
c.last_name,
COUNT(DISTINCT order_number) total_orders
FROM gold.fact_sales f
LEFT JOIN  gold.dim_customers c
ON c.customer_key = f.customer_key
GROUP BY
c.customer_key,
c.first_name,
c.last_name
ORDER BY total_orders