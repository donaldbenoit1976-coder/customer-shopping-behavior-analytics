-- =========================================
-- Data Cleaning and Validation
-- Project: KPI & Revenue Analysis
-- =========================================

-- 1. Preview raw data structure
SELECT *
FROM transactions
LIMIT 100;

-- 2. Check for missing values in key fields
SELECT
    SUM(CASE WHEN transaction_id IS NULL THEN 1 ELSE 0 END) AS missing_transaction_id,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS missing_customer_id,
    SUM(CASE WHEN revenue IS NULL THEN 1 ELSE 0 END) AS missing_revenue
FROM transactions;

-- 3. Remove invalid or negative revenue records (if applicable)
SELECT *
FROM transactions
WHERE revenue > 0;

-- 4. Check duplicate transactions
SELECT transaction_id, COUNT(*) AS duplicate_count
FROM transactions
GROUP BY transaction_id
HAVING COUNT(*) > 1;

-- 5. Create cleaned dataset view (standard practice)
CREATE VIEW clean_transactions AS
SELECT *
FROM transactions
WHERE revenue IS NOT NULL
  AND revenue > 0;
