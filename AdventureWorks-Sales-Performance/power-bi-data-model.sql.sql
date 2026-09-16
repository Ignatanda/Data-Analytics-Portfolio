
-- Fact Sales

SELECT
    soh.SalesOrderID,
    sod.SalesOrderDetailID,
    soh.OrderDate,
    soh.SalesPersonID,
    soh.TerritoryID,
    soh.CustomerID,
    sod.OrderQty,
    sod.UnitPrice,
    sod.UnitPriceDiscount,
    sod.OrderQty * sod.UnitPrice
        * (1 - sod.UnitPriceDiscount) AS SalesAmount
FROM Sales.SalesOrderHeader AS soh
INNER JOIN Sales.SalesOrderDetail AS sod
    ON soh.SalesOrderID = sod.SalesOrderID
WHERE soh.SalesPersonID IS NOT NULL;

--dimSalesPerson

SELECT
    sp.BusinessEntityID AS SalesPersonID,
    p.FirstName,
    p.LastName,
    CONCAT(p.FirstName, ' ', p.LastName) AS SalesPersonName,
    sp.TerritoryID,
    sp.SalesQuota,
    sp.Bonus,
    sp.CommissionPct
FROM Sales.SalesPerson AS sp
INNER JOIN Person.Person AS p
    ON sp.BusinessEntityID = p.BusinessEntityID;

--DimTerritory
SELECT
    TerritoryID,
    Name AS TerritoryName,
    CountryRegionCode,
    [Group] AS TerritoryGroup
FROM Sales.SalesTerritory;

--fact Quata

SELECT
    BusinessEntityID AS SalesPersonID,
    QuotaDate,
    SalesQuota
FROM Sales.SalesPersonQuotaHistory;

