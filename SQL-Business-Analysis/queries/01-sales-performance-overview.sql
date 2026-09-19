-- ============================================================
-- Exercise 01: Sales Performance Overview
-- Business Question:
-- What were the total sales, number of orders, quantity sold,
-- and average order value for each year?
-- ============================================================

SELECT
    YEAR(soh.OrderDate) AS YearOfOrder,
    SUM(sod.LineTotal) AS TotalSales,
    COUNT(DISTINCT sod.SalesOrderID) AS NumberOfOrders,
    SUM(sod.OrderQty) AS TotalQtySold,
    SUM(sod.LineTotal) / COUNT(DISTINCT sod.SalesOrderID) AS AvgOrderValue
FROM Sales.SalesOrderDetail AS sod
JOIN Sales.SalesOrderHeader AS soh
    ON sod.SalesOrderID = soh.SalesOrderID
GROUP BY YEAR(soh.OrderDate)
ORDER BY YearOfOrder ASC;
