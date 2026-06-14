-- =========================================
-- KPI Metrics Calculation
-- Project: Revenue & Business Insights
-- =========================================

-- Total Revenue
SELECT
    SUM(revenue) AS total_revenue
FROM clean_transactions;

-- Total Number of Records
SELECT
    COUNT(*) AS total_records
FROM clean_transactions;

-- Average Transaction Value
SELECT
    AVG(revenue) AS avg_transaction_value
FROM clean_transactions;

-- Revenue by Customer
SELECT
    customer_id,
    SUM(revenue) AS customer_revenue
FROM clean_transactions
GROUP BY customer_id
ORDER BY customer_revenue DESC;
