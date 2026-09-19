-- ============================================================
-- Exercise 04: Sales by Territory
-- Business Question:
-- Which territories generated the most revenue, and what
-- percentage of company sales did each territory contribute?
-- ============================================================

SELECT
    sst.Name AS TerritoryName,
    SUM(soh.TotalDue) AS TotalSales,
    CAST(
        SUM(soh.TotalDue) * 100.0
        / SUM(SUM(soh.TotalDue)) OVER ()
        AS DECIMAL(10,2)
    ) AS SalesPercentage
FROM Sales.SalesTerritory AS sst
JOIN Sales.SalesOrderHeader AS soh
    ON sst.TerritoryID = soh.TerritoryID
GROUP BY sst.Name
ORDER BY TotalSales DESC;
