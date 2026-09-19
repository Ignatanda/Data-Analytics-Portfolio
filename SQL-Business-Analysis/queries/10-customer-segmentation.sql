-- ============================================================
-- Exercise 10: Customer Segmentation
-- Business Question:
-- How can individual customers be segmented into four groups
-- based on their total spending?
-- ============================================================

;WITH Customers AS (
    SELECT
        c.CustomerID,
        CONCAT(pp.FirstName, ' ', pp.LastName) AS Name,
        SUM(soh.TotalDue) AS TotalSpending
    FROM Sales.SalesOrderHeader AS soh
    JOIN Sales.Customer AS c
        ON c.CustomerID = soh.CustomerID
    JOIN Person.Person AS pp
        ON c.PersonID = pp.BusinessEntityID
    GROUP BY
        c.CustomerID,
        pp.FirstName,
        pp.LastName
),
CustomerQuartiles AS (
    SELECT
        CustomerID,
        Name,
        TotalSpending,
        NTILE(4) OVER (ORDER BY TotalSpending) AS Quartile
    FROM Customers
)
SELECT
    CustomerID,
    Name,
    TotalSpending,
    Quartile,
    CASE Quartile
        WHEN 1 THEN 'Low'
        WHEN 2 THEN 'Medium'
        WHEN 3 THEN 'High'
        WHEN 4 THEN 'VIP'
    END AS Segment
FROM CustomerQuartiles
ORDER BY Quartile, TotalSpending DESC;
