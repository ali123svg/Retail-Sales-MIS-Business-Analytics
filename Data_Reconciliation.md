# Data Reconciliation — Excel vs MySQL vs Power BI

Comparing the core totals across all three systems to confirm consistency.

| Metric | Excel (Clean Data) | MySQL (fact_sales) | Power BI (Executive Summary) | Match? |
|---|---|---|---|---|
| Total Transactions | 41,400 | 41,400 | 41.4K | ✅ Match |
| Total Sales | ₹112,639,782.87 | ₹112,639,782.87 | 112.64M | ✅ Match |
| Total Profit | ₹44,638,012.87 | ₹44,638,012.87 | 44.64M | ✅ Match |
| Total Quantity | 77,286 | 77,286 | — (not shown on Exec Summary; add if needed) | ✅ Match (Excel/SQL) |
| Completed Orders | 38,604 | 38,604 | 38.6K (93.25% in donut) | ✅ Match |
| Returned Orders | 2,003 | 2,003 | 2K (4.84% in donut) | ✅ Match |
| Cancelled Orders | 793 | 793 | (~1.91% in donut) | ✅ Match |

## Result
All core totals reconcile across Excel, MySQL, and Power BI within rounding (Power BI displays abbreviated values like "112.64M" and "41.4K", which match the exact Excel/SQL figures when unrounded).

## Notes
- No mismatches were found in the core numeric totals — this is expected since Power BI is connected live to the same MySQL database that was loaded directly from the same Clean Data used in Excel, so all three sit on top of one single source of truth.
- If any future refresh introduces a mismatch, the most common cause (seen during this project) is an accidental "Removed Columns" step in Power Query silently dropping a field — check Power Query Editor's Applied Steps first before assuming a data issue.
- Quantity and Profit Margin % were not verified against a dedicated Power BI card in this pass; add a Quantity card to Executive Summary if you want it included in the visual reconciliation going forward.

## Known Issue: Category Naming Inconsistency Between fact_sales and dim_product

During reconciliation, a mismatch was found between the `Category` column in two different tables of the `retail_mis` database:

| Table | Category values |
|---|---|
| `fact_sales.Category` (used by all Power BI visuals) | Accessories, Apparel, **Bags**, Electronics, Footwear, **Home & Lifestyle**, **Sports & Fitness** |
| `dim_product.Category` (not currently used in any report) | Accessories, Apparel, Electronics, Footwear, **Fitness**, **Luggage**, **Home** |

**Root cause:** `fact_sales.Category` was populated directly from the Excel Clean Data during the CSV load, while `dim_product.Category` was defined independently when the dimension table was built — the two were never reconciled against each other.

**Impact:** None on current reports — every Power BI visual and SQL query in this project uses `fact_sales.Category` directly (not a join to `dim_product`), so all dashboard numbers are internally consistent and correct. However, this is a data modeling weakness: in a proper star schema, `fact_sales` should not need its own `Category`/`Sub_Category` columns at all — that's what `dim_product` is for. Having the field duplicated in both places, with different values, is exactly the kind of inconsistency a real MIS/Data Analyst is expected to catch and flag.

**Recommended fix (documented, not required for this version):** Standardize on one set of category names, update `dim_product.Category` to match `fact_sales.Category` (or vice versa), and going forward, pull `Category` into reports via the `dim_product` join rather than storing it redundantly in `fact_sales`. This is a good story to mention in an interview as a "found and documented a real data inconsistency" example.
