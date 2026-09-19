-- ============================================================
-- Exercise 02: Monthly Sales Trend
-- Business Question:
-- How did sales and order volume change month by month?
-- ============================================================

SELECT
    YEAR(soh.OrderDate) AS Year,
    MONTH(soh.OrderDate) AS Month,
    SUM(sod.LineTotal) AS TotalSales,
    COUNT(DISTINCT sod.SalesOrderID) AS Orders
FROM Sales.SalesOrderDetail AS sod
JOIN Sales.SalesOrderHeader AS soh
    ON sod.SalesOrderID = soh.SalesOrderID
GROUP BY
    YEAR(soh.OrderDate),
    MONTH(soh.OrderDate)
ORDER BY Year, Month;
