-- =========================================
-- Revenue Analysis
-- Trend & Business Insight Layer
-- =========================================

-- Revenue by Date
SELECT
    transaction_date,
    SUM(revenue) AS daily_revenue
FROM clean_transactions
GROUP BY transaction_date
ORDER BY transaction_date;

-- Top 10 Revenue Generating Customers
SELECT
    customer_id,
    SUM(revenue) AS total_revenue
FROM clean_transactions
GROUP BY customer_id
ORDER BY total_revenue DESC
LIMIT 10;

-- Revenue Distribution
SELECT
    CASE
        WHEN revenue < 100 THEN 'Low Value'
        WHEN revenue BETWEEN 100 AND 500 THEN 'Mid Value'
        ELSE 'High Value'
    END AS revenue_segment,
    COUNT(*) AS transaction_count
FROM clean_transactions
GROUP BY revenue_segment;
