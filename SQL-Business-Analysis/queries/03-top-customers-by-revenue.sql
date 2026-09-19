-- ============================================================
-- Exercise 03: Top 10 Customers by Revenue
-- Business Question:
-- Who are the top 10 individual customers by total revenue,
-- and how many orders did they place?
-- ============================================================

SELECT TOP 10
    c.CustomerID,
    CONCAT(pp.FirstName, ' ', pp.LastName) AS CustomerName,
    SUM(soh.TotalDue) AS TotalSales,
    COUNT(soh.SalesOrderID) AS Orders
FROM Sales.SalesOrderHeader AS soh
JOIN Sales.Customer AS c
    ON soh.CustomerID = c.CustomerID
JOIN Person.Person AS pp
    ON c.PersonID = pp.BusinessEntityID
GROUP BY
    c.CustomerID,
    pp.FirstName,
    pp.LastName
ORDER BY TotalSales DESC;
