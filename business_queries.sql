-- =====================================================================
-- RETAIL SALES MIS & BUSINESS ANALYTICS
-- SQL Business Analysis Queries
-- Database: retail_mis
-- =====================================================================
-- ASSUMED SCHEMA (adjust column names below if your tables differ):
--
-- dim_store   (Store_ID, Store_Name, City, State, Region)
-- dim_product (Product_ID, Product_Name, Category, Sub_Category)
-- fact_sales  (Order_ID, Order_Date, Customer_ID, Customer_Name,
--              Customer_Type, Gender, Age_Group, Store_ID, Salesperson,
--              Product_ID, Quantity, Unit_Price, Discount, Sales, Cost,
--              Profit, Payment_Method, Order_Status, Month, Week_Start,
--              Profit_Margin, Order_Flag)
-- fact_store_targets (currently EMPTY — target queries are skipped/optional)
-- =====================================================================

USE retail_mis;

-- =====================================================================
-- SECTION 1: SALES
-- =====================================================================

-- 1. Total Sales
SELECT SUM(Sales) AS Total_Sales
FROM fact_sales;

-- 2. Total Profit
SELECT SUM(Profit) AS Total_Profit
FROM fact_sales;

-- 3. Total Quantity
SELECT SUM(Quantity) AS Total_Quantity
FROM fact_sales;

-- 4. Monthly Sales
SELECT Month, SUM(Sales) AS Monthly_Sales
FROM fact_sales
GROUP BY Month
ORDER BY MIN(Order_Date);

-- 5. Monthly Profit
SELECT Month, SUM(Profit) AS Monthly_Profit
FROM fact_sales
GROUP BY Month
ORDER BY MIN(Order_Date);

-- 6. Month-over-Month Growth %
WITH monthly AS (
    SELECT Month, MIN(Order_Date) AS Month_Start, SUM(Sales) AS Total_Sales
    FROM fact_sales
    GROUP BY Month
)
SELECT
    Month,
    Total_Sales,
    LAG(Total_Sales) OVER (ORDER BY Month_Start) AS Prev_Month_Sales,
    ROUND(
        (Total_Sales - LAG(Total_Sales) OVER (ORDER BY Month_Start))
        / LAG(Total_Sales) OVER (ORDER BY Month_Start) * 100, 2
    ) AS MoM_Growth_Percent
FROM monthly
ORDER BY Month_Start;

-- 7. Average Order Value
SELECT
    ROUND(SUM(Sales) / COUNT(DISTINCT Order_ID), 2) AS Average_Order_Value
FROM fact_sales;

-- =====================================================================
-- SECTION 2: REGION
-- =====================================================================

-- 8. Region-wise Sales
SELECT s.Region, SUM(f.Sales) AS Region_Sales
FROM fact_sales f
JOIN dim_store s ON f.Store_ID = s.Store_ID
GROUP BY s.Region
ORDER BY Region_Sales DESC;

-- 9. Region-wise Profit
SELECT s.Region, SUM(f.Profit) AS Region_Profit
FROM fact_sales f
JOIN dim_store s ON f.Store_ID = s.Store_ID
GROUP BY s.Region
ORDER BY Region_Profit DESC;

-- 10. Region Contribution % to Total Sales
SELECT
    s.Region,
    SUM(f.Sales) AS Region_Sales,
    ROUND(SUM(f.Sales) * 100.0 / (SELECT SUM(Sales) FROM fact_sales), 2) AS Contribution_Percent
FROM fact_sales f
JOIN dim_store s ON f.Store_ID = s.Store_ID
GROUP BY s.Region
ORDER BY Region_Sales DESC;

-- 11. Best Region (by Sales)
SELECT s.Region, SUM(f.Sales) AS Region_Sales
FROM fact_sales f
JOIN dim_store s ON f.Store_ID = s.Store_ID
GROUP BY s.Region
ORDER BY Region_Sales DESC
LIMIT 1;

-- 12. Lowest Region (by Sales)
SELECT s.Region, SUM(f.Sales) AS Region_Sales
FROM fact_sales f
JOIN dim_store s ON f.Store_ID = s.Store_ID
GROUP BY s.Region
ORDER BY Region_Sales ASC
LIMIT 1;

-- =====================================================================
-- SECTION 3: STORE
-- =====================================================================

-- 13. Store-wise Sales
SELECT s.Store_Name, SUM(f.Sales) AS Store_Sales
FROM fact_sales f
JOIN dim_store s ON f.Store_ID = s.Store_ID
GROUP BY s.Store_Name
ORDER BY Store_Sales DESC;

-- 14. Store-wise Profit
SELECT s.Store_Name, SUM(f.Profit) AS Store_Profit
FROM fact_sales f
JOIN dim_store s ON f.Store_ID = s.Store_ID
GROUP BY s.Store_Name
ORDER BY Store_Profit DESC;

-- 15. Top 5 Stores (by Sales)
SELECT s.Store_Name, SUM(f.Sales) AS Store_Sales
FROM fact_sales f
JOIN dim_store s ON f.Store_ID = s.Store_ID
GROUP BY s.Store_Name
ORDER BY Store_Sales DESC
LIMIT 5;

-- 16. Bottom 5 Stores (by Sales)
SELECT s.Store_Name, SUM(f.Sales) AS Store_Sales
FROM fact_sales f
JOIN dim_store s ON f.Store_ID = s.Store_ID
GROUP BY s.Store_Name
ORDER BY Store_Sales ASC
LIMIT 5;

-- 17. Store Ranking (all stores, ranked by Sales)
SELECT
    s.Store_Name,
    SUM(f.Sales) AS Store_Sales,
    RANK() OVER (ORDER BY SUM(f.Sales) DESC) AS Sales_Rank
FROM fact_sales f
JOIN dim_store s ON f.Store_ID = s.Store_ID
GROUP BY s.Store_Name
ORDER BY Sales_Rank;

-- =====================================================================
-- SECTION 4: PRODUCT
-- =====================================================================

-- 18. Top 10 Products (by Sales)
SELECT p.Product_Name, SUM(f.Sales) AS Product_Sales
FROM fact_sales f
JOIN dim_product p ON f.Product_ID = p.Product_ID
GROUP BY p.Product_Name
ORDER BY Product_Sales DESC
LIMIT 10;

-- 19. Bottom 5 Products (by Sales)
SELECT p.Product_Name, SUM(f.Sales) AS Product_Sales
FROM fact_sales f
JOIN dim_product p ON f.Product_ID = p.Product_ID
GROUP BY p.Product_Name
ORDER BY Product_Sales ASC
LIMIT 5;

-- 20. Category Performance
SELECT p.Category, SUM(f.Sales) AS Category_Sales, SUM(f.Profit) AS Category_Profit
FROM fact_sales f
JOIN dim_product p ON f.Product_ID = p.Product_ID
GROUP BY p.Category
ORDER BY Category_Sales DESC;

-- 21. Sub-Category Performance
SELECT p.Sub_Category, SUM(f.Sales) AS SubCategory_Sales, SUM(f.Profit) AS SubCategory_Profit
FROM fact_sales f
JOIN dim_product p ON f.Product_ID = p.Product_ID
GROUP BY p.Sub_Category
ORDER BY SubCategory_Sales DESC;

-- 22. Product Contribution % to Total Sales
SELECT
    p.Product_Name,
    SUM(f.Sales) AS Product_Sales,
    ROUND(SUM(f.Sales) * 100.0 / (SELECT SUM(Sales) FROM fact_sales), 2) AS Contribution_Percent
FROM fact_sales f
JOIN dim_product p ON f.Product_ID = p.Product_ID
GROUP BY p.Product_Name
ORDER BY Product_Sales DESC;

-- =====================================================================
-- SECTION 5: CUSTOMER
-- =====================================================================

-- 23. Total Customers
SELECT COUNT(DISTINCT Customer_ID) AS Total_Customers
FROM fact_sales;

-- 24. Repeat Customers (customers with more than 1 order)
SELECT COUNT(*) AS Repeat_Customers
FROM (
    SELECT Customer_ID
    FROM fact_sales
    GROUP BY Customer_ID
    HAVING COUNT(DISTINCT Order_ID) > 1
) repeat_cust;

-- 25. Customer Purchase Frequency (orders per customer)
SELECT
    Customer_ID,
    Customer_Name,
    COUNT(DISTINCT Order_ID) AS Purchase_Frequency
FROM fact_sales
GROUP BY Customer_ID, Customer_Name
ORDER BY Purchase_Frequency DESC;

-- 26. Top 10 Customers (by Sales)
SELECT Customer_ID, Customer_Name, SUM(Sales) AS Customer_Sales
FROM fact_sales
GROUP BY Customer_ID, Customer_Name
ORDER BY Customer_Sales DESC
LIMIT 10;

-- 27. Customer Sales Contribution %
SELECT
    Customer_ID,
    Customer_Name,
    SUM(Sales) AS Customer_Sales,
    ROUND(SUM(Sales) * 100.0 / (SELECT SUM(Sales) FROM fact_sales), 2) AS Contribution_Percent
FROM fact_sales
GROUP BY Customer_ID, Customer_Name
ORDER BY Customer_Sales DESC;

-- 28. Average Customer Order Value
SELECT
    Customer_ID,
    Customer_Name,
    ROUND(SUM(Sales) / COUNT(DISTINCT Order_ID), 2) AS Avg_Order_Value
FROM fact_sales
GROUP BY Customer_ID, Customer_Name
ORDER BY Avg_Order_Value DESC;

-- =====================================================================
-- SECTION 6: ORDER STATUS
-- =====================================================================

-- 29. Completed Orders
SELECT COUNT(DISTINCT Order_ID) AS Completed_Orders
FROM fact_sales
WHERE Order_Status = 'Completed';

-- 30. Returned Orders
SELECT COUNT(DISTINCT Order_ID) AS Returned_Orders
FROM fact_sales
WHERE Order_Status = 'Returned';

-- 31. Cancelled Orders
SELECT COUNT(DISTINCT Order_ID) AS Cancelled_Orders
FROM fact_sales
WHERE Order_Status = 'Cancelled';

-- 32. Return Rate %
SELECT
    ROUND(
        (SELECT COUNT(DISTINCT Order_ID) FROM fact_sales WHERE Order_Status = 'Returned')
        * 100.0 / (SELECT COUNT(DISTINCT Order_ID) FROM fact_sales), 2
    ) AS Return_Rate_Percent;

-- 33. Sales Impact of Returns (Sales lost due to returns)
SELECT
    Order_Status,
    SUM(Sales) AS Sales,
    SUM(Profit) AS Profit
FROM fact_sales
GROUP BY Order_Status;

-- =====================================================================
-- SECTION 7: PAYMENT
-- =====================================================================

-- 34. Payment Method Analysis
SELECT
    Payment_Method,
    COUNT(DISTINCT Order_ID) AS Orders,
    SUM(Sales) AS Total_Sales,
    ROUND(SUM(Sales) * 100.0 / (SELECT SUM(Sales) FROM fact_sales), 2) AS Contribution_Percent
FROM fact_sales
GROUP BY Payment_Method
ORDER BY Total_Sales DESC;

-- =====================================================================
-- SECTION 8: SALESPERSON
-- =====================================================================

-- 35. Salesperson Performance
SELECT
    Salesperson,
    COUNT(DISTINCT Order_ID) AS Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM fact_sales
GROUP BY Salesperson
ORDER BY Total_Sales DESC;

-- =====================================================================
-- SECTION 9: TARGET (OPTIONAL — only if fact_store_targets gets reliable data)
-- =====================================================================

-- 36. Target Achievement (SKIP for now — fact_store_targets is empty)
-- Uncomment and use only once target data is loaded and verified.
--
-- SELECT
--     s.Store_Name,
--     t.Target,
--     SUM(f.Sales) AS Actual_Sales,
--     ROUND(SUM(f.Sales) * 100.0 / t.Target, 2) AS Target_Achievement_Percent
-- FROM fact_sales f
-- JOIN dim_store s ON f.Store_ID = s.Store_ID
-- JOIN fact_store_targets t ON f.Store_ID = t.Store_ID
-- GROUP BY s.Store_Name, t.Target;
