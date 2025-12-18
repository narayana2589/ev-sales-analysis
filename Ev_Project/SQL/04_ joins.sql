-- =========================================================
-- File: 04_joins.sql
-- Purpose: Demonstrate INNER JOIN and LEFT JOIN usage
--          on normalized EV sales data
-- Database: ev_sales_analysis
-- =========================================================


-- ---------------------------------------------------------
-- 1. INNER JOIN
-- Purpose: Combine EV sales with manufacturer master
-- Only matching records from both tables are returned
-- ---------------------------------------------------------

SELECT
    e.State,
    e.Manufacturer,
    e.Vehicle_Category,
    e.Sales_Units
FROM ev_raw_data e
INNER JOIN manufacturer_master m
    ON e.Manufacturer = m.Manufacturer;


-- ---------------------------------------------------------
-- 2. INNER JOIN + Filter
-- Purpose: Show 2W EV sales for valid manufacturers only
-- ---------------------------------------------------------

SELECT
    e.State,
    e.Manufacturer,
    e.Sales_Units
FROM ev_raw_data e
INNER JOIN manufacturer_master m
    ON e.Manufacturer = m.Manufacturer
WHERE e.Vehicle_Category = '2W';


-- ---------------------------------------------------------
-- 3. INNER JOIN + Aggregation
-- Purpose: Total EV sales per manufacturer
-- ---------------------------------------------------------

SELECT
    m.Manufacturer,
    SUM(e.Sales_Units) AS Total_Sales
FROM ev_raw_data e
INNER JOIN manufacturer_master m
    ON e.Manufacturer = m.Manufacturer
GROUP BY m.Manufacturer
ORDER BY Total_Sales DESC;


-- ---------------------------------------------------------
-- 4. LEFT JOIN
-- Purpose: Keep all EV sales records even if no match
-- ---------------------------------------------------------

SELECT
    e.State,
    e.Manufacturer,
    e.Sales_Units
FROM ev_raw_data e
LEFT JOIN manufacturer_master m
    ON e.Manufacturer = m.Manufacturer;


-- ---------------------------------------------------------
-- 5. LEFT JOIN to Identify Unmatched Records
-- Purpose: Data quality check (invalid manufacturers)
-- ---------------------------------------------------------

SELECT
    e.Manufacturer,
    e.State,
    e.Sales_Units
FROM ev_raw_data e
LEFT JOIN manufacturer_master m
    ON e.Manufacturer = m.Manufacturer
WHERE m.Manufacturer IS NULL;


-- ---------------------------------------------------------
-- 6. LEFT JOIN + Aggregation
-- Purpose: Show all manufacturers with total EV sales
-- Includes manufacturers with zero sales
-- ---------------------------------------------------------

SELECT
    m.Manufacturer,
    SUM(e.Sales_Units) AS Total_Sales
FROM manufacturer_master m
LEFT JOIN ev_raw_data e
    ON m.Manufacturer = e.Manufacturer
GROUP BY m.Manufacturer
ORDER BY Total_Sales DESC;


-- ---------------------------------------------------------
-- 7. LEFT JOIN with Condition in ON clause
-- Purpose: Correct way to filter while preserving LEFT JOIN
-- ---------------------------------------------------------

SELECT
    m.Manufacturer,
    SUM(e.Sales_Units) AS Total_2W_Sales
FROM manufacturer_master m
LEFT JOIN ev_raw_data e
    ON m.Manufacturer = e.Manufacturer
   AND e.Vehicle_Category = '2W'
GROUP BY m.Manufacturer
ORDER BY Total_2W_Sales DESC;


-- =========================================================
-- End of JOIN analysis
-- =========================================================
