-- ============================================================
-- Exercise 11: Customer Purchase Frequency
-- Business Question:
-- How many customers made only one purchase versus repeat
-- purchases, and what percentage belongs to each group?
-- ============================================================

;WITH CustomerOrders AS (
    SELECT
        CustomerID,
        COUNT(SalesOrderID) AS NumberOfOrders
    FROM Sales.SalesOrderHeader
    GROUP BY CustomerID
),
GroupCustomers AS (
    SELECT
        CustomerID,
        CASE
            WHEN NumberOfOrders = 1 THEN 'One Purchase'
            WHEN NumberOfOrders > 1 THEN 'Repeat Purchase'
        END AS PurchaseType
    FROM CustomerOrders
)
SELECT
    PurchaseType,
    COUNT(*) AS Customers,
    CAST(
        COUNT(*) * 100.0
        / SUM(COUNT(*)) OVER ()
        AS DECIMAL(10,2)
    ) AS Percentage
FROM GroupCustomers
GROUP BY PurchaseType
ORDER BY Customers DESC;
