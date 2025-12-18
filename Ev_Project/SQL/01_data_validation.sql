-- =========================================================
-- File: 01_data_validation.sql
-- Purpose: Validate raw EV sales data before analysis
-- Database: ev_sales_analysis
-- =========================================================


-- ---------------------------------------------------------
-- 1. Total number of records
-- ---------------------------------------------------------
SELECT
    COUNT(*) AS total_records
FROM ev_raw_data;


-- ---------------------------------------------------------
-- 2. Year coverage of the dataset
-- ---------------------------------------------------------
SELECT
    MIN(Year) AS start_year,
    MAX(Year) AS end_year
FROM ev_raw_data;


-- ---------------------------------------------------------
-- 3. Distinct states covered
-- ---------------------------------------------------------
SELECT DISTINCT
    State
FROM ev_raw_data
ORDER BY State;


-- ---------------------------------------------------------
-- 4. Distinct manufacturers present
-- ---------------------------------------------------------
SELECT DISTINCT
    Manufacturer
FROM ev_raw_data
ORDER BY Manufacturer;


-- ---------------------------------------------------------
-- 5. Vehicle categories available
-- ---------------------------------------------------------
SELECT DISTINCT
    Vehicle_Category
FROM ev_raw_data
ORDER BY Vehicle_Category;


-- ---------------------------------------------------------
-- 6. Check for NULL values in key columns
-- ---------------------------------------------------------
SELECT
    COUNT(*) AS null_records
FROM ev_raw_data
WHERE State IS NULL
   OR Manufacturer IS NULL
   OR Sales_Units IS NULL;


-- =========================================================
-- End of data validation
-- =========================================================
