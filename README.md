# Retail Sales MIS & Business Analytics — End-to-End Reporting System

> **Note:** This is a fictional retail business scenario built as a portfolio project to demonstrate end-to-end MIS and Business Analytics skills. No real company, client, or employment relationship is implied.

## Project Overview

An end-to-end retail reporting and analytics system simulating the work of an MIS Executive / Data Analyst — from raw sales data through cleaning, MIS reporting, database design, SQL analysis, and an interactive Power BI dashboard.

**Workflow:** Raw Sales Data → Data Cleaning (Power Query) → Excel MIS Reporting → MySQL Database → SQL Business Analysis → Power BI Data Model & DAX → Management Dashboard → Business Insights → Management Report

## Business Problem

A fictional medium-sized Indian retail company needs a repeatable reporting system to track sales, profit, store/region performance, and customer behavior — replacing manual, ad-hoc reporting with a structured, automated MIS and BI workflow.

## Business Scenario

The project simulates receiving raw monthly sales data, cleaning it into a reliable dataset, producing recurring MIS reports, loading the data into a relational database for SQL analysis, and building management-facing Power BI dashboards.

## Dataset Overview

- **41,400** cleaned transaction records
- **20** products across **7** categories
- **16** stores across **4** regions (South, West, North, East)
- Fields: Order details, Customer demographics, Product/Category, Store/Region, Sales, Cost, Profit, Discount, Payment Method, Order Status, and more

> **Key Numbers:** Total Sales **₹112,639,782.87** | Total Profit **₹44,638,012.87** | Order Completion Rate **93.25%**

## Tools & Technologies

- **Excel** — MIS reporting, pivot-based summaries
- **Power Query** — repeatable data cleaning pipeline
- **VBA / Macros** — Monthly MIS report automation
- **MySQL** — relational database (star schema)
- **SQL** — business analysis queries
- **Power BI** — data modeling, DAX, interactive dashboards
- **Git / GitHub** — version control and portfolio hosting

## End-to-End Workflow

### 1. Excel MIS
`Retail_Sales_MIS_Report.xlsx` with Raw Data, Clean Data, Daily/Weekly/Monthly MIS, and Product/Store/Region/Customer performance sheets, plus a Management Summary.

### 2. Power Query
A repeatable cleaning pipeline: combine monthly files → remove duplicates → handle nulls → trim/standardize text → correct data types → maintain calculated columns → final Clean Data — designed so future months can be processed without repeating manual steps.

### 3. VBA Automation
A macro (`Generate Monthly MIS Report`) that takes a month as input and automatically populates the Monthly MIS sheet with filtered totals, reducing repetitive manual reporting.

### 4. MySQL Database
A star-schema database (`retail_mis`) with `dim_store`, `dim_product`, and `fact_sales` tables, joined on `Store_ID` and `Product_ID`.

### 5. SQL Analysis
36 business queries covering sales trends, region/store/product/customer rankings, order status, payment methods, and salesperson performance (see `SQL/business_queries.sql`).

### 6. Power BI Dashboard
A 4-page interactive dashboard:
- **Executive Summary** — Total Sales/Profit/Orders cards, Sales by Category/Region, Monthly Trend
- **Sales Analysis** — Top 10 Products, Sales by Store, Order Status, Region×Category, Sub-Category, with 5 slicers
- **Store & Region Performance** — Store-wise Sales/Profit, Region comparison, Top 5/Bottom 5 stores, Profit Margin %
- **Customer Analysis** — Total/Repeat Customers, Average Order Value, Customer Type split, Top 10 Customers, Sales by Age Group

## KPIs

| KPI | Definition |
|---|---|
| Total Sales | Sum of Sales |
| Total Profit | Sum of Profit |
| Total Orders | Count of unique Order_ID |
| Profit Margin % | Profit / Sales |
| Average Order Value | Sales / Total Orders |
| Return Rate | Returned Orders / Total Orders |
| MoM Sales Growth | (Current Month − Previous Month) / Previous Month |

Full definitions in `KPI_Definitions.md`.

## Key Insights

- **South and West regions lead sales** (~₹31–32M each); **East trails by ~40%**.
- **Bengaluru Indiranagar is the top-performing store**; the weakest 5 stores are all Tier-2/Tier-3 cities.
- **Apparel is the leading category** by both sales and quantity.
- **Sales spike sharply from October–December** (festive season), flat the rest of the year.
- **93.25% order completion rate**; returns and cancellations are within a healthy range.
- **Corporate customers drive ~74% of revenue** despite likely being a smaller segment than Regular customers.

Full detail in `Business_Insights.md`.

## Business Recommendations

- **Investigate and address the East region performance gap.**
- **Build a localized strategy for non-metro stores** rather than replicating the metro playbook.
- **Prioritize inventory/marketing for Apparel, Electronics, and Footwear.**
- **Plan staffing and stock ahead of the Q4 seasonal surge.**
- **Strengthen retention for high-value Corporate accounts.**
- **Grow order value from existing repeat customers** via cross-sell/bundling.

Full detail in `Management_Recommendations.md`.

## Screenshots

See the `Screenshots/` folder for the Excel Management Summary, MySQL tables, SQL query results, and all 4 Power BI dashboard pages.

## Project Outcome

A **fully reconciled**, end-to-end MIS and analytics system where **Excel, MySQL, and Power BI totals match exactly**, backed by concrete, data-driven business insights and recommendations — reflecting the kind of ownership expected in an entry-level MIS Executive / Data Analyst role.

## Repository Structure

```
Retail-Sales-MIS-Business-Analytics/
├── Excel/
│   └── Retail_Sales_MIS_Report.xlsx
├── SQL/
│   ├── database_schema.sql
│   ├── data_import.sql
│   └── business_queries.sql
├── PowerBI/
│   └── Retail_Sales_MIS.pbix
├── VBA/
│   └── Monthly_MIS_Automation.xlsm
├── Reports/
│   └── Management_Report.docx
├── Screenshots/
└── README.md
```
