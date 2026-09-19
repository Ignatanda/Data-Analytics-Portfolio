-- ============================================================
-- Exercise 12: Salesperson Quota Performance
-- Business Question:
-- For each salesperson and quarter, compare actual sales with
-- sales quota, calculate the quota gap and achievement
-- percentage, and rank salespeople based on performance.
-- ============================================================

;WITH SalesPerQuarter AS (
    SELECT
        soh.SalesPersonID,
        CONCAT(pp.FirstName, ' ', pp.LastName) AS Name,
        YEAR(soh.OrderDate) AS Year,
        DATEPART(QUARTER, soh.OrderDate) AS Quarter,
        SUM(soh.TotalDue) AS TotalSales
    FROM Sales.SalesOrderHeader AS soh
    JOIN Person.Person AS pp
        ON soh.SalesPersonID = pp.BusinessEntityID
    WHERE soh.SalesPersonID IS NOT NULL
    GROUP BY
        soh.SalesPersonID,
        pp.FirstName,
        pp.LastName,
        YEAR(soh.OrderDate),
        DATEPART(QUARTER, soh.OrderDate)
),
QuotaPerQuarter AS (
    SELECT
        BusinessEntityID AS SalesPersonID,
        YEAR(QuotaDate) AS Year,
        DATEPART(QUARTER, QuotaDate) AS Quarter,
        SUM(SalesQuota) AS SalesQuota
    FROM Sales.SalesPersonQuotaHistory
    GROUP BY
        BusinessEntityID,
        YEAR(QuotaDate),
        DATEPART(QUARTER, QuotaDate)
),
Performance AS (
    SELECT
        spq.SalesPersonID,
        spq.Name,
        spq.Year,
        spq.Quarter,
        spq.TotalSales,
        qpq.SalesQuota,
        spq.TotalSales - qpq.SalesQuota AS QuotaGap,
        CAST(
            spq.TotalSales * 100.0 / NULLIF(qpq.SalesQuota, 0)
            AS DECIMAL(10,2)
        ) AS AchievementPercentage
    FROM SalesPerQuarter AS spq
    JOIN QuotaPerQuarter AS qpq
        ON spq.SalesPersonID = qpq.SalesPersonID
        AND spq.Year = qpq.Year
        AND spq.Quarter = qpq.Quarter
)
SELECT
    Name,
    Year,
    Quarter,
    TotalSales,
    SalesQuota,
    QuotaGap,
    AchievementPercentage,
    RANK() OVER (
        PARTITION BY Year, Quarter
        ORDER BY AchievementPercentage DESC
    ) AS PerformanceRank
FROM Performance
ORDER BY
    Year,
    Quarter,
    PerformanceRank;
