# 📊 Northwind Business Performance Analysis (SQL + Power BI)

## Overview
This project demonstrates an end-to-end Data Analytics workflow using **PostgreSQL**, advanced **SQL queries**, **DAX measures**, **data modeling**, and **Power BI visualizations** to analyze business performance across sales, customers, products, shipping efficiency, and employee productivity.

---

## Project Overview

The primary objective of this project is to answer basic → intermediate → advanced business questions using SQL and bring those insights into a fully interactive Power BI dashboard.

**Technologies Used**

**PostgreSQL** — joins, aggregations, window functions, CTEs

**Power BI** — data modeling, DAX, dashboarding

**DAX Measures** — Revenue, AOV, LTV, YoY calculations

**GitHub** — documentation & version control

---

## 🔍 Dataset

This project uses the Northwind dataset, a well-known sample database that simulates a global wholesale food distribution company.

It contains realistic business entities:

- Customers

- Orders

- Order Details

- Products

- Categories

- Employees

- Shippers

### Northwind is ideal for analytics involving:

- Revenue performance

- Customer value & segmentation

- Order lifecycle

- Shipping delays

### Employee sales productivity

📥 Dataset Source (PostgreSQL compatible):
👉 https://github.com/pthom/northwind_psql

---

## 🧠 SQL Queries (Basic → Advanced Business Problems)
**📌 Basic SQL**

- Top 10 products by revenue

- Monthly revenue trend

- Products never ordered

- Delayed orders

**📌 Intermediate SQL**

- Top customers by LTV + % of total revenue

- High-value customers (AOV > global average)

- Top-selling product per category

- Customers with most delayed shipments

**📌 Advanced SQL**

- Customer churn year-over-year

- Employee performance ranking + YoY % change

✔ Includes CTEs, NOT EXISTS, ROW_NUMBER, RANK, LAG
✔ Queries follow production-grade SQL practices

---
## 📈 Power BI Dashboard

After SQL extraction, Power BI was used for:

**📌 Key DAX Measures**

- Total Revenue

- Total Customers

- Total Orders

- AOV (Average Order Value)

- Customer LTV

- Delayed Orders

- Employee YoY Sales Change

- Previous Year Sales

**📌 Dashboard Features**

- KPI Cards (Revenue, Orders, Customers, AOV, Delays)

- Top 10 Products by Revenue

- Monthly Revenue Trend

- Customer LTV Leaderboard

- Delayed Shipment Analysis

- Employee YoY Performance Table

- Slicers: Year, Category, Country

- Professional Dark Theme
  
---
  ## 🖼 Dashboard Preview
![Northwind Dashboard](dashboard.png)

---
## 🎯 Business Insights

- Revenue is dominated by a few top products (Pareto distribution).

- April is the highest revenue month; May is the lowest.

- 37 delayed orders indicate shipping inefficiencies.

- Top customers contribute the majority of revenue → customer dependency risk.

- Some employees show 300–500% YoY growth, others show declines → opportunities for coaching.
  
---

## 🧩 How to Run the Project

- Import the Northwind schema into PostgreSQL

- Run the SQL scripts using pgAdmin

- Connect PostgreSQL to Power BI

- Load raw tables (Import mode recommended)

- Create DAX measures

- Build visuals using the recommended layout

- (Optional) Publish to Power BI Service

---

## 🏁 Conclusion

This project demonstrates a complete, real-world Data Analyst workflow including:

- Data extraction using advanced SQL

- Data modeling

- Analytical DAX calculations

- Power BI dashboard development

- Business insight generation

A strong portfolio piece showcasing skills in SQL, BI, data modeling, and storytelling with data.

---
