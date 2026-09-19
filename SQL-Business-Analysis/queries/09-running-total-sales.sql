-- ============================================================
-- Exercise 09: Running Total of Sales
-- Business Question:
-- What is the cumulative sales total by month within each year?
-- ============================================================

;WITH MonthlySales AS (
    SELECT
        YEAR(OrderDate) AS Year,
        MONTH(OrderDate) AS Month,
        SUM(TotalDue) AS TotalSales
    FROM Sales.SalesOrderHeader
    GROUP BY
        YEAR(OrderDate),
        MONTH(OrderDate)
),
SalesRunningTotal AS (
    SELECT
        Year,
        Month,
        TotalSales,
        SUM(TotalSales) OVER (
            PARTITION BY Year
            ORDER BY Month
        ) AS RunningTotal
    FROM MonthlySales
)
SELECT
    Year,
    Month,
    TotalSales,
    RunningTotal
FROM SalesRunningTotal
ORDER BY Year, Month;
