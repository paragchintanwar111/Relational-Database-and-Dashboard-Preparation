-- ============================================
-- SALES DATA ANALYSIS PROJECT
-- Database: Sales_Project
-- Table: sql dataset
-- Total Records: 10684
-- ============================================

-- 1. DATABASE AND TABLE CHECK

USE Sales_Project;

SHOW TABLES;

SELECT
    COUNT(*) AS Total_Records
FROM `sql dataset`;


-- 2. DATA CLEANING / DATA QUALITY CHECK

-- Check duplicate Order Numbers
SELECT
    `OrderNumber`,
    COUNT(*) AS Order_Count
FROM `sql dataset`
GROUP BY `OrderNumber`
HAVING COUNT(*) > 1;

-- Check total and unique rows
SELECT
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT CONCAT_WS('|',
        `OrderNumber`,
        `OrderDate`,
        `Customer Name Index`,
        `Channel`,
        `Currency Code`,
        `Warehouse Code`,
        `Delivery Region Index`,
        `Product Description Index`,
        `Order Quantity`,
        `Unit Price`,
        `Line Total`,
        `Total Unit Cost`
    )) AS Unique_Rows
FROM `sql dataset`;

-- Check NULL values
SELECT
    SUM(`OrderNumber` IS NULL) AS Null_OrderNumber,
    SUM(`OrderDate` IS NULL) AS Null_OrderDate,
    SUM(`Customer Name Index` IS NULL) AS Null_Customer,
    SUM(`Channel` IS NULL) AS Null_Channel,
    SUM(`Currency Code` IS NULL) AS Null_Currency,
    SUM(`Warehouse Code` IS NULL) AS Null_Warehouse,
    SUM(`Delivery Region Index` IS NULL) AS Null_Region,
    SUM(`Product Description Index` IS NULL) AS Null_Product,
    SUM(`Order Quantity` IS NULL) AS Null_Quantity,
    SUM(`Unit Price` IS NULL) AS Null_UnitPrice,
    SUM(`Line Total` IS NULL) AS Null_LineTotal,
    SUM(`Total Unit Cost` IS NULL) AS Null_UnitCost
FROM `sql dataset`;


-- 3. KPI ANALYSIS

SELECT
    COUNT(*) AS Total_Orders,
    SUM(`Order Quantity`) AS Total_Quantity,
    ROUND(
        SUM(CAST(REPLACE(`Line Total`, ',', '') AS DECIMAL(15,2))),
        2
    ) AS Total_Sales,
    ROUND(
        SUM(CAST(REPLACE(`Total Unit Cost`, ',', '') AS DECIMAL(15,2))),
        2
    ) AS Total_Cost,
    ROUND(
        SUM(CAST(REPLACE(`Line Total`, ',', '') AS DECIMAL(15,2)))
        -
        SUM(CAST(REPLACE(`Total Unit Cost`, ',', '') AS DECIMAL(15,2))),
        2
    ) AS Total_Profit
FROM `sql dataset`;


-- 4. BUSINESS PERFORMANCE ANALYSIS

-- Sales by Channel
SELECT
    `Channel`,
    COUNT(*) AS Total_Orders,
    SUM(`Order Quantity`) AS Total_Quantity,
    ROUND(
        SUM(CAST(REPLACE(`Line Total`, ',', '') AS DECIMAL(15,2))),
        2
    ) AS Total_Sales
FROM `sql dataset`
GROUP BY `Channel`
ORDER BY Total_Sales DESC;

-- Profit by Channel
SELECT
    `Channel`,
    ROUND(
        SUM(CAST(REPLACE(`Line Total`, ',', '') AS DECIMAL(15,2)))
        -
        SUM(CAST(REPLACE(`Total Unit Cost`, ',', '') AS DECIMAL(15,2))),
        2
    ) AS Total_Profit
FROM `sql dataset`
GROUP BY `Channel`
ORDER BY Total_Profit DESC;

-- Sales by Warehouse
SELECT
    `Warehouse Code`,
    COUNT(*) AS Total_Orders,
    SUM(`Order Quantity`) AS Total_Quantity,
    ROUND(
        SUM(CAST(REPLACE(`Line Total`, ',', '') AS DECIMAL(15,2))),
        2
    ) AS Total_Sales
FROM `sql dataset`
GROUP BY `Warehouse Code`
ORDER BY Total_Sales DESC;

-- Top 10 Products
SELECT
    `Product Description Index`,
    SUM(`Order Quantity`) AS Total_Quantity,
    ROUND(
        SUM(CAST(REPLACE(`Line Total`, ',', '') AS DECIMAL(15,2))),
        2
    ) AS Total_Sales
FROM `sql dataset`
GROUP BY `Product Description Index`
ORDER BY Total_Sales DESC
LIMIT 10;


-- 5. CUSTOMER ANALYSIS

-- Top 10 Customers by Sales
SELECT
    `Customer Name Index`,
    COUNT(*) AS Total_Orders,
    SUM(`Order Quantity`) AS Total_Quantity,
    ROUND(
        SUM(CAST(REPLACE(`Line Total`, ',', '') AS DECIMAL(15,2))),
        2
    ) AS Total_Sales
FROM `sql dataset`
GROUP BY `Customer Name Index`
ORDER BY Total_Sales DESC
LIMIT 10;


-- 6. REGIONAL ANALYSIS

-- Sales by Delivery Region
SELECT
    `Delivery Region Index`,
    COUNT(*) AS Total_Orders,
    SUM(`Order Quantity`) AS Total_Quantity,
    ROUND(
        SUM(CAST(REPLACE(`Line Total`, ',', '') AS DECIMAL(15,2))),
        2
    ) AS Total_Sales
FROM `sql dataset`
GROUP BY `Delivery Region Index`
ORDER BY Total_Sales DESC;


-- 7. MONTHLY SALES TREND

SELECT
    DATE_FORMAT(
        STR_TO_DATE(`OrderDate`, '%c/%e/%Y'),
        '%Y-%m'
    ) AS Sales_Month,
    ROUND(
        SUM(CAST(REPLACE(`Line Total`, ',', '') AS DECIMAL(15,2))),
        2
    ) AS Total_Sales
FROM `sql dataset`
GROUP BY Sales_Month
ORDER BY Sales_Month;


-- 8. AVERAGE ORDER VALUE

SELECT
    ROUND(
        SUM(CAST(REPLACE(`Line Total`, ',', '') AS DECIMAL(15,2)))
        / COUNT(*),
        2
    ) AS Average_Order_Value
FROM `sql dataset`;


-- 9. FINAL BUSINESS INSIGHTS

-- 1. Identify the highest-performing sales channel.
-- 2. Identify the most profitable sales channel.
-- 3. Identify the warehouse with the highest Total Sales.
-- 4. Identify the top-performing product.
-- 5. Identify the top customer.
-- 6. Identify the highest-performing delivery region.
-- 7. Identify the highest and lowest sales months.
-- 8. Report the Average Order Value.
-- 9. Report Total Orders, Quantity, Sales, Cost and Profit.
-- 10. Mention duplicate and NULL check results.