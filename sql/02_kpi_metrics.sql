-- =========================================
-- KPI Metrics Calculation
-- Project: Revenue & Business Insights
-- =========================================

-- Total Revenue
SELECT
  ROUND(
      SUM(Quantity * UnitPrice),
      2
  ) AS total_revenue
FROM `data_analysis_project1.retail_analytics.online_retail_clean`;

-- Total Number of Customers
SELECT
    COUNT(DISTINCT CustomerID) AS unique_customers
FROM `data_analysis_project1.retail_analytics.online_retail_clean`
WHERE CustomerID IS NOT NULL;

-- How Many Orders Were Placed
SELECT
    COUNT(DISTINCT InvoiceNo) AS total_orders
FROM `data_analysis_project1.retail_analytics.online_retail_clean`;

-- Average Order Value (AVO)
WITH order_totals AS (
    SELECT
        InvoiceNo,
        SUM(Quantity * UnitPrice) AS order_value
    FROM `data_analysis_project1.retail_analytics.online_retail_clean`
    GROUP BY InvoiceNo
)

SELECT
    ROUND(AVG(order_value),2) AS average_order_value
FROM order_totals;

-- Revenue by Customer for the top 10
SELECT
    CustomerID,
    ROUND(SUM(Quantity * UnitPrice),2) AS revenue
FROM `data_analysis_project1.retail_analytics.online_retail_clean`
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY revenue DESC
LIMIT 10;
