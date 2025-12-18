-- =========================================================
-- File: 03_aggregations.sql
-- Purpose: Aggregated EV sales insights and KPIs
-- Database: ev_sales_analysis
-- =========================================================


-- ---------------------------------------------------------
-- 1. State-wise total EV sales
-- ---------------------------------------------------------
SELECT
    State,
    SUM(Sales_Units) AS total_sales
FROM ev_raw_data
GROUP BY State
ORDER BY total_sales DESC;


-- ---------------------------------------------------------
-- 2. Year-wise total EV sales trend
-- ---------------------------------------------------------
SELECT
    Year,
    SUM(Sales_Units) AS yearly_sales
FROM ev_raw_data
GROUP BY Year
ORDER BY Year;


-- ---------------------------------------------------------
-- 3. Vehicle category-wise EV sales
-- ---------------------------------------------------------
SELECT
    Vehicle_Category,
    SUM(Sales_Units) AS total_sales
FROM ev_raw_data
GROUP BY Vehicle_Category
ORDER BY total_sales DESC;


-- ---------------------------------------------------------
-- 4. Manufacturer-wise EV performance
-- Includes average, total sales, and record count
-- ---------------------------------------------------------
SELECT
    Manufacturer,
    AVG(Sales_Units)  AS avg_sales,
    COUNT(*)          AS record_count,
    SUM(Sales_Units)  AS total_sales
FROM ev_raw_data
GROUP BY Manufacturer
ORDER BY total_sales DESC;


-- ---------------------------------------------------------
-- 5. High-performing manufacturers (2W category)
-- ---------------------------------------------------------
SELECT
    Manufacturer,
    AVG(Sales_Units)  AS avg_2w_sales,
    COUNT(*)          AS record_count,
    SUM(Sales_Units)  AS total_2w_sales
FROM ev_raw_data
WHERE Vehicle_Category = '2W'
GROUP BY Manufacturer
HAVING AVG(Sales_Units) > 5000
ORDER BY avg_2w_sales DESC;


-- ---------------------------------------------------------
-- 6. Top states by total EV sales
-- ---------------------------------------------------------
SELECT
    State,
    SUM(Sales_Units) AS total_sales
FROM ev_raw_data
GROUP BY State
ORDER BY total_sales DESC
LIMIT 10;


-- =========================================================
-- End of aggregation analysis
-- =========================================================
