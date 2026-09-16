/*
    Casino Gaming Analytics
    SQL queries used to prepare the relational database
    tables for the Power BI data model.

    Database: CasinoAnalytics
*/

-- =====================================================
-- FACT SESSIONS
-- =====================================================

SELECT
    SessionID,
    PlayerID,
    DealerID,
    TableID,
    StartTime,
    EndTime,
    DurationMin,
    TotalBet,
    TotalPayout,
    Profit
FROM dbo.Sessions;


-- =====================================================
-- FACT TRANSACTIONS
-- =====================================================

SELECT
    TransactionID,
    PlayerID,
    TransactionType,
    Amount,
    TransactionDate
FROM dbo.Transactions;


-- =====================================================
-- DIM PLAYERS
-- =====================================================

SELECT
    PlayerID,
    CONCAT(FirstName, ' ', LastName) AS Name,
    Gender,
    Age,
    CASE
        WHEN Country = 'UK' THEN 'United Kingdom'
        ELSE Country
    END AS Country,
    RegistrationDate,
    VIPLevel,
    CASE
        WHEN VIPLevel = 'Bronze' THEN 1
        WHEN VIPLevel = 'Silver' THEN 2
        WHEN VIPLevel = 'Gold' THEN 3
        WHEN VIPLevel = 'Platinum' THEN 4
    END AS VIPLevelOrder,
    Status
FROM dbo.Players;


-- =====================================================
-- DIM DEALERS
-- =====================================================

SELECT
    DealerID,
    CONCAT(FirstName, ' ', LastName) AS DealerName,
    Language,
    ExperienceYears,
    Shift
FROM dbo.Dealers;


-- =====================================================
-- DIM TABLES
-- =====================================================

SELECT
    TableID,
    TableName,
    GameID,
    Studio,
    Capacity
FROM dbo.CasinoTables;


-- =====================================================
-- DIM GAMES
-- =====================================================

SELECT
    GameID,
    GameName,
    HouseEdge
FROM dbo.Games;