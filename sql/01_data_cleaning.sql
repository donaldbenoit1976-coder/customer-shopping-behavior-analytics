-- =========================================
-- Data Cleaning and Validation
-- Project: KPI & Revenue Analysis
-- =========================================

-- 0. Verify the data table 
SELECT COUNT(*)
FROM `data_analysis_project1.retail_analytics.online_retail_raw`;

-- 1. Preview raw data struc
SELECT *
FROM `data_analysis_project1.retail_analytics.online_retail_raw`
LIMIT 10;

-- 2. Check for missing values in key fields
SELECT
  COUNT(*) AS total_rows,
  COUNTIF(CustomerID IS NULL) AS missing_customerid,
  COUNTIF(Description IS NULL) AS missing_description,
  COUNTIF(UnitPrice IS NULL) AS missing_unitprice,
  COUNTIF(Quantity IS NULL) AS missing_quantity
FROM `data_analysis_project1.retail_analytics.online_retail_raw`;

-- 3. Check for refunded transactions
SELECT
  COUNT(*) AS cancelled_orders
FROM `data_analysis_project1.retail_analytics.online_retail_raw`
WHERE InvoiceNo LIKE 'C%';

-- 4. Check invalid or negative quantity records (if applicable)
SELECT
  COUNT(*) AS negative_quantity_rows
FROM `data_analysis_project1.retail_analytics.online_retail_raw`
WHERE Quantity < 0;

-- 5. Check duplicate transactions
SELECT
  SUM(record_count - 1) AS duplicate_rows
FROM (
  SELECT
    COUNT(*) AS record_count
  FROM `data_analysis_project1.retail_analytics.online_retail_raw`
  GROUP BY
    InvoiceNo,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    UnitPrice,
    CustomerID,
    Country
  HAVING COUNT(*) > 1
);

-- 6. Create cleaned dataset view (standard practice)
CREATE OR REPLACE TABLE
`data_analysis_project1.retail_analytics.online_retail_clean` AS

SELECT DISTINCT
    InvoiceNo,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    UnitPrice,
    CustomerID,
    Country
FROM
    `data_analysis_project1.retail_analytics.online_retail_raw`
WHERE
    Description IS NOT NULL
    AND Quantity > 0
    AND UnitPrice > 0
    AND InvoiceNo NOT LIKE 'C%';

-- Verify the clean table
SELECT COUNT(*)
FROM `data_analysis_project1.retail_analytics.online_retail_clean`;
