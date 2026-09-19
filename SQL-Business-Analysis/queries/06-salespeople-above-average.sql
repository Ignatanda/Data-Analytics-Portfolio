-- ============================================================
-- Exercise 06: Salespeople Above Company Average
-- Business Question:
-- Which salespeople generated more revenue than the average
-- salesperson?
-- ============================================================

;WITH SalespersonSales AS (
    SELECT
        sp.BusinessEntityID AS SalesPersonID,
        CONCAT(pp.FirstName, ' ', pp.LastName) AS Name,
        SUM(soh.TotalDue) AS TotalSales
    FROM Sales.SalesOrderHeader AS soh
    JOIN Sales.SalesPerson AS sp
        ON soh.SalesPersonID = sp.BusinessEntityID
    JOIN Person.Person AS pp
        ON pp.BusinessEntityID = sp.BusinessEntityID
    GROUP BY
        sp.BusinessEntityID,
        pp.FirstName,
        pp.LastName
),
CompanyAverage AS (
    SELECT AVG(TotalSales) AS AvgTotalSales
    FROM SalespersonSales
)
SELECT
    ss.Name,
    ss.TotalSales,
    ca.AvgTotalSales
FROM SalespersonSales AS ss
CROSS JOIN CompanyAverage AS ca
WHERE ss.TotalSales > ca.AvgTotalSales
ORDER BY ss.TotalSales DESC;
