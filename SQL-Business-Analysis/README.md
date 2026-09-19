# SQL Business Analysis – AdventureWorks 2022

## Project Overview

This project contains 12 SQL business analysis exercises built using the **AdventureWorks 2022** sample database.

The goal is to answer realistic business questions related to sales performance, customers, products, territories, and salesperson performance while demonstrating practical SQL skills used in data analysis.

## Tools & Skills

- SQL Server / T-SQL
- JOINs and aggregate functions
- CTEs and subqueries
- CASE expressions and conditional aggregation
- Window functions: `LAG()`, `RANK()`, `NTILE()`
- Date functions and quarterly analysis
- Percentage, growth, and running-total calculations

## Business Questions

1. **Sales Performance Overview**  
   What were the total sales, number of orders, quantity sold, and average order value for each year?

2. **Monthly Sales Trend**  
   How did total sales and number of orders evolve month by month?

3. **Top 10 Customers by Revenue**  
   Which customers generated the highest total revenue, and how many orders did they place?

4. **Sales by Territory**  
   Which territories generated the highest revenue, and what percentage of company sales did each territory represent?

5. **Salespeople Performance**  
   How much revenue did each salesperson generate, how many orders did they handle, and what was their average order value?

6. **Salespeople Above Company Average**  
   Which salespeople generated more revenue than the average salesperson?

7. **Top 3 Products by Revenue within each Product Category**  
   Which three products generated the most revenue within each product category?

8. **Monthly Sales Growth**  
   How did sales change from one month to the next, both in value and percentage?

9. **Running Total of Sales**  
   How did cumulative sales develop over time?

10. **Customer Segmentation**  
    How can customers be segmented into revenue-based groups according to their total spending?

11. **Customer Purchase Frequency**  
    How many customers made only one purchase versus repeat purchases, and what percentage of customers belongs to each group?

12. **Salesperson Quota Performance**  
    For each salesperson and quarter, how did actual sales compare with sales quota, what was the quota gap and achievement percentage, and how did each salesperson rank within the quarter?

## Project Structure

```text
SQL-Business-Analysis/
│
├── README.md
│
└── queries/
    ├── 01-sales-performance-overview.sql
    ├── 02-monthly-sales-trend.sql
    ├── 03-top-customers-by-revenue.sql
    ├── 04-sales-by-territory.sql
    ├── 05-salespeople-performance.sql
    ├── 06-salespeople-above-average.sql
    ├── 07-top-products-by-category.sql
    ├── 08-monthly-sales-growth.sql
    ├── 09-running-total-sales.sql
    ├── 10-customer-segmentation.sql
    ├── 11-customer-purchase-frequency.sql
    └── 12-salesperson-quota-performance.sql
```

Each SQL file contains the business question followed by the query used to answer it.

## Database

The analysis uses Microsoft's **AdventureWorks 2022** sample database.

Main tables used:

- `Sales.SalesOrderHeader`
- `Sales.SalesOrderDetail`
- `Sales.Customer`
- `Sales.SalesPerson`
- `Sales.SalesPersonQuotaHistory`
- `Sales.SalesTerritory`
- `Person.Person`
- `Production.Product`
- `Production.ProductSubcategory`
- `Production.ProductCategory`

## What This Project Demonstrates

The exercises progress from aggregation and grouping to more advanced analytical SQL.

Later queries combine multiple tables, CTEs, date logic, window functions, ranking, customer segmentation, month-over-month growth, running totals, and salesperson quota analysis.

The project demonstrates both **SQL technical skills** and the ability to translate **business questions into structured analytical queries**.
