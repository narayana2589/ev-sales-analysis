-- =========================================================
-- File: 02_filtering_analysis.sql
-- Purpose: Exploratory filtering and sorting analysis
-- Database: ev_sales_analysis
-- =========================================================


-- ---------------------------------------------------------
-- 1. Top EV sales records by sales units
-- ---------------------------------------------------------
SELECT
    State,
    Manufacturer,
    Vehicle_Category,
    Sales_Units
FROM ev_raw_data
ORDER BY Sales_Units DESC
LIMIT 10;


-- ---------------------------------------------------------
-- 2. Filter EV sales for 2W category
-- ---------------------------------------------------------
SELECT
    State,
    Manufacturer,
    Sales_Units
FROM ev_raw_data
WHERE Vehicle_Category = '2W'
ORDER BY Sales_Units DESC
LIMIT 10;


-- ---------------------------------------------------------
-- 3. EV sales for selected manufacturers
-- ---------------------------------------------------------
SELECT
    State,
    Manufacturer,
    Vehicle_Category,
    Sales_Units
FROM ev_raw_data
WHERE Manufacturer IN ('Tata', 'Mahindra')
ORDER BY Sales_Units DESC;


-- ---------------------------------------------------------
-- 4. State-wise EV sales for a specific year
-- ---------------------------------------------------------
SELECT
    State,
    Manufacturer,
    Sales_Units
FROM ev_raw_data
WHERE Year = 2022
ORDER BY Sales_Units DESC;


-- ---------------------------------------------------------
-- 5. Lowest EV sales records (outlier check)
-- ---------------------------------------------------------
SELECT
    State,
    Manufacturer,
    Sales_Units
FROM ev_raw_data
ORDER BY Sales_Units ASC
LIMIT 10;


-- =========================================================
-- End of filtering analysis
-- =========================================================
