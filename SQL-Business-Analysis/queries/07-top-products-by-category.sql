-- ============================================================
-- Exercise 07: Top 3 Products by Revenue within each Category
-- Business Question:
-- Which three products generated the most revenue within each
-- product category?
-- ============================================================

;WITH RankedCategory AS (
    SELECT
        pp.Name AS ProductName,
        SUM(sod.LineTotal) AS TotalSales,
        pc.Name AS CategoryName,
        RANK() OVER (
            PARTITION BY pc.Name
            ORDER BY SUM(sod.LineTotal) DESC
        ) AS ProductRank
    FROM Production.Product AS pp
    JOIN Sales.SalesOrderDetail AS sod
        ON sod.ProductID = pp.ProductID
    JOIN Production.ProductSubcategory AS ps
        ON ps.ProductSubcategoryID = pp.ProductSubcategoryID
    JOIN Production.ProductCategory AS pc
        ON pc.ProductCategoryID = ps.ProductCategoryID
    GROUP BY
        pp.Name,
        pc.Name
)
SELECT
    ProductName,
    TotalSales,
    CategoryName,
    ProductRank
FROM RankedCategory
WHERE ProductRank <= 3
ORDER BY CategoryName, ProductRank, TotalSales DESC;
