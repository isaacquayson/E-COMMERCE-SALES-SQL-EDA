-- CREATING DATABASE 
CREATE DATABASE STORE_SALES;

START TRANSACTION;

-- VIEWING THE DATA TABLES
SELECT * FROM store_sales.countries;
SELECT * FROM store_sales.products;
SELECT * FROM store_sales.sales_2016;
SELECT * FROM store_sales.sales_2017;
SELECT * FROM store_sales.sales_2018;
SELECT * FROM store_sales.sales_2019;


-- CHECKING NULL SPACES IN THE DATA TABLES 

-- 2016
SELECT * FROM store_sales.sales_2016 
WHERE 
( sales_2016.`Order ID` IS NULL OR sales_2016.`Order ID` = ''
OR sales_2016.Date IS NULL OR sales_2016.Date = ''
OR sales_2016.Product IS NULL OR sales_2016.Product = ''
OR sales_2016.`Country Code` IS NULL OR sales_2016.`Country Code` = ''
OR sales_2016.UnitCost IS NULL OR sales_2016.UnitCost = ''
OR sales_2016.UnitPrice IS NULL OR sales_2016.UnitPrice = ''
OR sales_2016.SalesQuantity IS NULL OR sales_2016.SalesQuantity = ''
OR sales_2016.TotalCost IS NULL OR sales_2016.TotalCost = ''
OR sales_2016.TotalPrice IS NULL OR sales_2016.TotalPrice = ''
OR sales_2016.TotalProfit IS NULL OR sales_2016.TotalProfit = '' );


-- 2017
SELECT * FROM store_sales.sales_2017
WHERE 
( sales_2017.`Order ID` IS NULL OR sales_2017.`Order ID` = ''
OR sales_2017.Date IS NULL OR sales_2017.Date = ''
OR sales_2017.Product IS NULL OR sales_2017.Product = ''
OR sales_2017.`Country Code` IS NULL OR sales_2017.`Country Code` = ''
OR sales_2017.UnitCost IS NULL OR sales_2017.UnitCost = ''
OR sales_2017.UnitPrice IS NULL OR sales_2017.UnitPrice = ''
OR sales_2017.SalesQuantity IS NULL OR sales_2017.SalesQuantity = ''
OR sales_2017.TotalCost IS NULL OR sales_2017.TotalCost = ''
OR sales_2017.TotalPrice IS NULL OR sales_2017.TotalPrice = ''
OR sales_2017.TotalProfit IS NULL OR sales_2017.TotalProfit = '' );


-- 2018
SELECT * FROM store_sales.sales_2018
WHERE 
( sales_2018.`Order ID` IS NULL OR sales_2018.`Order ID` = ''
OR sales_2018.Date IS NULL OR sales_2018.Date = ''
OR sales_2018.Product IS NULL OR sales_2018.Product = ''
OR sales_2018.`Country Code` IS NULL OR sales_2018.`Country Code` = ''
OR sales_2018.UnitCost IS NULL OR sales_2018.UnitCost = ''
OR sales_2018.UnitPrice IS NULL OR sales_2018.UnitPrice = ''
OR sales_2018.SalesQuantity IS NULL OR sales_2018.SalesQuantity = ''
OR sales_2018.TotalCost IS NULL OR sales_2018.TotalCost = ''
OR sales_2018.TotalPrice IS NULL OR sales_2018.TotalPrice = ''
OR sales_2018.TotalProfit IS NULL OR sales_2018.TotalProfit = '' );


-- 2019
SELECT * FROM store_sales.sales_2019
WHERE 
( sales_2019.`Order ID` IS NULL OR sales_2019.`Order ID` = ''
OR sales_2019.Date IS NULL OR sales_2019.Date = ''
OR sales_2019.Product IS NULL OR sales_2019.Product = ''
OR sales_2019.`Country Code` IS NULL OR sales_2019.`Country Code` = ''
OR sales_2019.UnitCost IS NULL OR sales_2019.UnitCost = ''
OR sales_2019.UnitPrice IS NULL OR sales_2019.UnitPrice = ''
OR sales_2019.SalesQuantity IS NULL OR sales_2019.SalesQuantity = ''
OR sales_2019.TotalCost IS NULL OR sales_2019.TotalCost = ''
OR sales_2019.TotalPrice IS NULL OR sales_2019.TotalPrice = ''
OR sales_2019.TotalProfit IS NULL OR sales_2019.TotalProfit = '' );


-- JOINING THE SALES TABLES INTO SINGLE TABLE 

CREATE TABLE sales_table AS
(
	SELECT * from store_sales.sales_2016
	UNION ALL
	SELECT * FROM store_sales.sales_2017
	UNION ALL
	SELECT * FROM store_sales.sales_2018
	UNION ALL 
	SELECT * FROM store_sales.sales_2019);


-- VIEWING THE NEW TABLE     
SELECT * FROM store_sales.sales_table;


-- TOTAL RECORDS IN THE TABLE 
SELECT COUNT(*) AS 'TOTAL RECORDS' FROM store_sales.sales_table;


-- CHECKING FOR DUPLICATES IN THE DATA
SELECT *, COUNT(*) AS duplicate_records
FROM sales_table
GROUP BY 
  sales_table.`Order ID`, sales_table.Date, sales_table.Product, sales_table.`Country Code`, 
  sales_table.UnitCost, sales_table.UnitPrice, sales_table.SalesQuantity, 
  sales_table.TotalCost, sales_table.TotalPrice, sales_table.TotalProfit
HAVING COUNT(*) > 1;


-- ADDING MONTH AND YEAR COLUMNS TO THE TABLE 

ALTER TABLE sales_table
ADD COLUMN Year INT, ADD COLUMN Month VARCHAR(20);


UPDATE sales_table
SET 
  Year = CASE SUBSTRING(Date, 7, 4)
            WHEN '2016' THEN 2016
            WHEN '2017' THEN 2017
            WHEN '2018' THEN 2018
            WHEN '2019' THEN 2019
            ELSE NULL
         END,
  Month = CASE SUBSTRING(Date, 4, 2)
             WHEN '01' THEN 'January'
             WHEN '02' THEN 'February'
             WHEN '03' THEN 'March'
             WHEN '04' THEN 'April'
             WHEN '05' THEN 'May'
             WHEN '06' THEN 'June'
             WHEN '07countries' THEN 'July'
             WHEN '08' THEN 'August'
             WHEN '09' THEN 'September'
             WHEN '10' THEN 'October'
             WHEN '11' THEN 'November'
             WHEN '12' THEN 'December'
             ELSE NULL
          END;

-- COMMITING TO THE DATABASE TABLE
COMMIT;


-- TOTAL COST, PRICE, AND PROFIT FOR EACH YEAR
SELECT 
    sales_table.Year,
    ROUND(SUM(sales_table.TotalCost), 2) AS 'TotalCost',
    ROUND(SUM(sales_table.TotalPrice), 2) AS 'TotalPrice',
    ROUND(SUM(sales_table.TotalProfit), 2) AS 'TotalProfit'
FROM
    sales_table
GROUP BY sales_table.Year
ORDER BY SUM(sales_table.TotalProfit) DESC;


-- GROUPING THE TOTAL PROFIT BY MONTH 
SELECT 
    sales_table.Month,
    ROUND(SUM(sales_table.TotalProfit), 2) AS 'TotalProfit'
FROM
    sales_table
GROUP BY sales_table.Month
ORDER BY SUM(sales_table.TotalProfit) DESC;


-- TOTAL COST, PRICE, AND PROFIT PER COUNTRIES IN EVERY YEAR
-- 2016
SELECT 
    sales_table.`Country Code`,
    ROUND(SUM(sales_table.TotalProfit), 2) AS 'TOTAL PROFIT',
    ROUND(SUM(sales_table.TotalCost), 2) AS 'TotalCost',
    ROUND(SUM(sales_table.TotalPrice), 2) AS 'TotalPrice'
FROM
    sales_table
WHERE
    sales_table.Year = 2016
GROUP BY sales_table.`Country Code`
ORDER BY ROUND(SUM(sales_table.TotalProfit), 2) DESC;


-- 2017
SELECT 
    sales_table.`Country Code`,
    ROUND(SUM(sales_table.TotalProfit), 2) AS 'TOTAL PROFIT',
    ROUND(SUM(sales_table.TotalCost), 2) AS 'TotalCost',
    ROUND(SUM(sales_table.TotalPrice), 2) AS 'TotalPrice'
FROM
    sales_table
WHERE
    sales_table.Year = 2017
GROUP BY sales_table.`Country Code`
ORDER BY 1 DESC;  


-- 2018
SELECT 
    sales_table.`Country Code`,
    ROUND(SUM(sales_table.TotalProfit), 2) AS 'TOTAL PROFIT',
    ROUND(SUM(sales_table.TotalCost), 2) AS 'TotalCost',
    ROUND(SUM(sales_table.TotalPrice), 2) AS 'TotalPrice'
FROM
    sales_table
WHERE
    sales_table.Year = 2018
GROUP BY sales_table.`Country Code`
ORDER BY ROUND(SUM(sales_table.TotalProfit), 2) DESC;


-- 2019
SELECT 
    sales_table.`Country Code`,
    ROUND(SUM(sales_table.TotalProfit), 2) AS 'TOTAL PROFIT',
    ROUND(SUM(sales_table.TotalCost), 2) AS 'TotalCost',
    ROUND(SUM(sales_table.TotalPrice), 2) AS 'TotalPrice'
FROM
    sales_table
WHERE
    sales_table.Year = 2019
GROUP BY sales_table.`Country Code`
ORDER BY ROUND(SUM(sales_table.TotalProfit), 2) DESC;


-- TOTAL PROFIT PER COUNTRY FROM 2016 TO 2019
SELECT 
    sales_table.`Country Code`,
    ROUND(SUM(sales_table.TotalProfit), 2) AS 'TOTAL PROFIT'
FROM sales_table
GROUP BY 1
ORDER BY 2 DESC;


-- ADDING CATEGORY COLUMN TO THE TABLE AND FILL IT 
ALTER TABLE sales_table ADD COLUMN category VARCHAR(40);


UPDATE sales_table
SET sales_table.category = 'pastries'
where sales_table.Product like 'Almond%';


UPDATE sales_table
SET sales_table.category = 'pastries'
WHERE sales_table.Product LIKE 'Almond%' OR sales_table.Product LIKE 'Chocolate%' 
OR sales_table.Product LIKE 'Blueberry%' OR sales_table.Product LIKE 'Butter%';


UPDATE sales_table
SET sales_table.category = 'beverages'
WHERE sales_table.Product LIKE 'Tomato%' OR sales_table.Product LIKE 'Green%' 
OR sales_table.Product LIKE 'Still%' OR sales_table.Product LIKE 'Peach%'
OR sales_table.Product LIKE 'Apple%' OR sales_table.Product LIKE 'Orange%'
OR sales_table.Product LIKE 'Lemon%' OR sales_table.Product LIKE 'Coffee%'
OR sales_table.Product LIKE 'Sparkling%' OR sales_table.Product LIKE 'Tea%';


UPDATE sales_table
SET sales_table.category = 'food'
WHERE sales_table.Product LIKE 'Fruit%' OR sales_table.Product LIKE 'BLT%' 
OR sales_table.Product LIKE 'Cheese%' OR sales_table.Product LIKE 'Ham%'
OR sales_table.Product LIKE 'Chicken%' OR sales_table.Product LIKE 'Toast%'
OR sales_table.Product LIKE 'Porri%' OR sales_table.Product LIKE 'Tuna%'
OR sales_table.Product LIKE 'Granola%' OR sales_table.Product LIKE 'Yoghurt%';


-- TOTAL PROFIT BY EACH PRODUCTS CATEGORY
SELECT sales_table.category, ROUND(SUM(sales_table.TotalProfit), 2) AS 'TOTAL PROFIT'
FROM sales_table
GROUP BY 1
ORDER BY 2 DESC;


-- TOP 10 HIGH PERFORMIGN PRODUCTS IN EACH YEAR 
SELECT Year, Product, Total_Profit
FROM (
    SELECT 
        Year,
        Product,
        ROUND(SUM(TotalProfit), 2) AS Total_Profit,
        RANK() OVER (PARTITION BY Year ORDER BY SUM(TotalProfit) DESC) AS rank_in_year
    FROM sales_table
    GROUP BY Year, Product
) AS ranked_products
WHERE rank_in_year <= 10
ORDER BY Year, rank_in_year;


-- Year on Year Growth from 2016 - 2019
SELECT 
  Year,
  ROUND(SUM(TotalProfit), 2) AS Profit,
  LAG(ROUND(SUM(TotalProfit), 2)) OVER (ORDER BY Year) AS Prev_Year_Profit,
  ROUND(
    (ROUND(SUM(TotalProfit), 2) - LAG(ROUND(SUM(TotalProfit), 2)) OVER (ORDER BY Year)) /
    LAG(ROUND(SUM(TotalProfit), 2)) OVER (ORDER BY Year) * 100, 2
  ) AS YoY_Growth_Percent
FROM sales_table
GROUP BY Year;

SELECT  count( DISTINCT sales_table.`Country Code`) from sales_table
