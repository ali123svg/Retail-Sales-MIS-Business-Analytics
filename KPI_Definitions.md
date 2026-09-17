# KPI Definitions — Retail Sales MIS & Business Analytics

These definitions are used consistently across Excel, SQL, and Power BI.

| KPI | Definition | Formula |
|---|---|---|
| **Total Sales** | Sum of all sales value across transactions | `SUM(Sales)` |
| **Total Profit** | Sum of all profit generated | `SUM(Profit)` |
| **Total Orders** | Count of unique orders placed | `COUNT(DISTINCT Order_ID)` |
| **Total Quantity** | Total units sold | `SUM(Quantity)` |
| **Profit Margin %** | Profit as a percentage of sales | `Profit / Sales` |
| **Average Order Value (AOV)** | Average value of a single order | `Sales / Total Orders` |
| **Return Rate** | Percentage of orders that were returned | `Returned Orders / Total Orders` |
| **MoM Sales Growth** | Sales growth compared to the previous month | `(Current Month Sales − Previous Month Sales) / Previous Month Sales` |
| **Region/Store/Product/Customer Contribution %** | Share of total sales contributed by that segment | `Segment Sales / Total Sales` |
| **Repeat Customer** | A customer with more than 1 distinct order | `COUNT(Order_ID) > 1 per Customer_ID` |
| **Average Revenue per Customer** | Average sales value generated per customer | `Total Sales / Total Customers` |
| **Completed / Returned / Cancelled Orders** | Count of orders in each Order_Status | `COUNT(DISTINCT Order_ID)` filtered by status |

## Notes
- All KPIs are calculated from the **Clean Data** in Excel, the `fact_sales` table in MySQL, and the corresponding DAX measures in Power BI — the same definitions are used everywhere so numbers reconcile.
- Cancelled orders contribute ₹0 to Sales and Profit (per your actual project data), so they are excluded from Sales/Profit KPIs but included in order-count and status-based KPIs.
