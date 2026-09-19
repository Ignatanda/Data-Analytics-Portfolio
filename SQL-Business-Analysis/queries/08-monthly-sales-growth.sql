-- ============================================================
-- Exercise 08: Monthly Sales Growth
-- Business Question:
-- How did sales change from one month to the next, both in
-- value and percentage?
-- ============================================================

;WITH SalesPerMonth AS (
    SELECT
        YEAR(OrderDate) AS Year,
        MONTH(OrderDate) AS Month,
        SUM(TotalDue) AS TotalSales
    FROM Sales.SalesOrderHeader
    GROUP BY
        YEAR(OrderDate),
        MONTH(OrderDate)
),
SalesWithPreviousMonth AS (
    SELECT
        Year,
        Month,
        TotalSales,
        LAG(TotalSales) OVER (
            ORDER BY Year, Month
        ) AS PreviousMonthSales
    FROM SalesPerMonth
)
SELECT
    Year,
    Month,
    TotalSales,
    PreviousMonthSales,
    TotalSales - PreviousMonthSales AS SalesChange,
    CAST(
        (TotalSales - PreviousMonthSales) * 100.0
        / NULLIF(PreviousMonthSales, 0)
        AS DECIMAL(10,2)
    ) AS GrowthPercentage
FROM SalesWithPreviousMonth
ORDER BY Year, Month;
