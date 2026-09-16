
# 📊 AdventureWorks Sales Performance | SQL & Power BI

## Project Overview

This project was developed as the final Power BI project of the Data Analysis course at **IT School**.

Using the AdventureWorks dataset, the project focuses on sales performance and salesperson analysis, combining SQL for data preparation with Power BI and DAX for data modelling, KPI development and interactive reporting.

The report analyzes overall sales performance, sales quotas, salesperson achievement and year-over-year performance.

---

## 🛠 Tools & Technologies

- **SQL Server** — source database
- **SQL** — data extraction and preparation
- **Power BI** — data modelling and dashboard development
- **DAX** — KPIs, time intelligence and performance analysis

---

## 🎯 Analysis Objectives

The project was designed to answer several business questions:

- How are total sales and orders performing?
- How does sales performance change over time?
- How do current sales compare with the previous year?
- Which salespeople generate the highest sales?
- How does actual sales performance compare with assigned quotas?
- Which salespeople are above or below their targets?
- How do sales results vary across territories?
- How does an individual salesperson perform over time?

---

# 📊 Dashboard

## 1. Sales Overview

Provides a high-level overview of sales performance using key KPIs and sales trends.

The page focuses on overall sales activity, order volume, year-over-year performance, territories and salesperson contribution.

![Sales Overview](images/1.Sales%20Overview.jpg)

---

## 2. Sales Team Performance

Focuses on salesperson performance against assigned sales quotas.

The analysis uses Sales, Sales Quota, Achievement %, Quota Gap and Performance Rank to compare members of the sales team and identify differences in target achievement.

![Sales Team Performance](images/2.Sales%20Team%20Performance.jpg)

---

## 3. Salesperson Details

Provides a detailed view of an individual salesperson.

The page allows performance to be analyzed at salesperson level, including sales results, quota achievement and quarterly performance.

![Salesperson Details](images/3.Salesperson%20Details.jpg)

---

## 4. Report Documentation

The report also includes a documentation page explaining the purpose and structure of the Power BI analysis.

![Report Documentation](images/4.Report%20Documentation.jpg)

---

# 🗃 Data Model

The Power BI model combines sales transactions with salesperson, territory, date and sales quota information to support both overall and salesperson-level analysis.

![Power BI Data Model](images/5.Model%20View.jpg)

---

# 💻 SQL

SQL was used to extract and prepare the AdventureWorks data required for the Power BI model.

The analysis uses sales order data together with salesperson, territory and quota information.

The SQL queries used for the project are available here:

[`power-bi-data-model.sql`](power-bi-data-model.sql)

---

# 📐 DAX

DAX measures were created to calculate sales KPIs, time-intelligence metrics and salesperson performance.

Selected measures include:

- Total Sales
- Total Orders
- Total Quantity Sold
- Average Order Value
- Sales LY
- Sales YoY %
- Sales Quota
- Achievement %
- Quota Gap
- Performance Rank

Selected DAX measures are available here:

[`key-measures.dax`](key-measures.dax)

---

## 📁 Repository Structure

```text
AdventureWorks-Sales-Performance/
│
├── AdventureWorks-Sales-Performance.pbix
├── power-bi-data-model.sql
├── key-measures.dax
├── README.md
│
└── images/
    ├── 1.Sales Overview.jpg
    ├── 2.Sales Team Performance.jpg
    ├── 3.Salesperson Details.jpg
    ├── 4.Report Documentation.jpg
    └── 5.Model View.jpg
```

---

## About This Project

This project represents the final Power BI project completed during my Data Analysis course at IT School.

It demonstrates the process of preparing data with SQL, building a Power BI data model, creating DAX measures and translating sales data into an interactive performance report.
