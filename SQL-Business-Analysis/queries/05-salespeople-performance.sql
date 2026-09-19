-- ============================================================
-- Exercise 05: Salespeople Performance
-- Business Question:
-- What were total sales, number of orders, and average order
-- value for each salesperson?
-- ============================================================

SELECT
    CONCAT(pp.FirstName, ' ', pp.LastName) AS Name,
    SUM(soh.TotalDue) AS TotalSales,
    COUNT(soh.SalesOrderID) AS Orders,
    SUM(soh.TotalDue) / COUNT(soh.SalesOrderID) AS AvgOrderValue
FROM Person.Person AS pp
JOIN Sales.SalesPerson AS sp
    ON pp.BusinessEntityID = sp.BusinessEntityID
JOIN Sales.SalesOrderHeader AS soh
    ON soh.SalesPersonID = sp.BusinessEntityID
GROUP BY
    sp.BusinessEntityID,
    pp.FirstName,
    pp.LastName
ORDER BY TotalSales DESC;
