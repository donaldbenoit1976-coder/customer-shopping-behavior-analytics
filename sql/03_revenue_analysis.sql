-- =========================================
-- Revenue Analysis
-- Trend & Business Insight Layer
-- Pareto Analysis 
-- =========================================

-- Revenue Mothly Trends
SELECT
    FORMAT_TIMESTAMP('%Y-%m', InvoiceDate) AS month,
    ROUND(SUM(Quantity * UnitPrice),2) AS revenue
FROM `data_analysis_project1.retail_analytics.online_retail_clean`
GROUP BY month
ORDER BY month;

-- Revenue by Country
SELECT
    Country,
    ROUND(SUM(Quantity * UnitPrice),2) AS revenue
FROM `data_analysis_project1.retail_analytics.online_retail_clean`
GROUP BY Country
ORDER BY revenue DESC
LIMIT 15;

--Product Performance
SELECT
    Description,
    SUM(Quantity) AS units_sold,
    ROUND(SUM(Quantity * UnitPrice),2) AS revenue
FROM `data_analysis_project1.retail_analytics.online_retail_clean`
GROUP BY Description
ORDER BY revenue DESC
LIMIT 15;

-- Stock Code for top 15
SELECT
    StockCode,
    Description,
    SUM(Quantity) AS units_sold
FROM `data_analysis_project1.retail_analytics.online_retail_clean`
GROUP BY StockCode, Description
ORDER BY units_sold DESC
LIMIT 15;

-- Cleaner Product View
SELECT
    Description,
    SUM(Quantity) AS units_sold,
    ROUND(SUM(Quantity * UnitPrice),2) AS revenue
FROM `data_analysis_project1.retail_analytics.online_retail_clean`
WHERE UPPER(Description) NOT IN (
    'DOTCOM POSTAGE',
    'POSTAGE',
    'MANUAL'
)
GROUP BY Description
ORDER BY revenue DESC
LIMIT 15;

-- Build Customer Revenue Table
CREATE OR REPLACE TABLE
`data_analysis_project1.retail_analytics.customer_revenue` AS

SELECT
    CustomerID,
    COUNT(DISTINCT InvoiceNo) AS orders,
    ROUND(SUM(Quantity * UnitPrice),2) AS revenue
FROM `data_analysis_project1.retail_analytics.online_retail_clean`
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID;

-- Verify the Table
SELECT
    COUNT(*) AS customers
FROM `data_analysis_project1.retail_analytics.customer_revenue`;

-- Repeat Customer Analysis
SELECT
    COUNT(*) AS repeat_customers
FROM `data_analysis_project1.retail_analytics.customer_revenue`
WHERE orders > 1;

-- Customer Revenue Distribution
SELECT
  CASE
    WHEN revenue >= 10000 THEN 'High Value'
    WHEN revenue >= 1000 THEN 'Medium Value'
    ELSE 'Low Value'
  END AS customer_segment,
  COUNT(*) AS customers,
  ROUND(SUM(revenue),2) AS segment_revenue
FROM `data_analysis_project1.retail_analytics.customer_revenue`
GROUP BY customer_segment
ORDER BY segment_revenue DESC;

-- Pareto Analysis 80/20
WITH customer_rank AS (
    SELECT
        CustomerID,
        revenue,
        SUM(revenue) OVER (ORDER BY revenue DESC) AS cumulative_revenue,
        SUM(revenue) OVER () AS total_revenue
    FROM `data_analysis_project1.retail_analytics.customer_revenue`
)

SELECT
    COUNT(*) AS customers_for_80_percent
FROM customer_rank
WHERE cumulative_revenue <= total_revenue * 0.8;

