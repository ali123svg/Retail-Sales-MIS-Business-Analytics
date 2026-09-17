# Business Insights — Retail Sales MIS & Business Analytics

All figures below are taken directly from the completed Power BI dashboard and Excel Management Summary.

---

### 1. Regional Performance Is Uneven

**Observation:** Of the 4 regions, South and West are nearly tied as the top performers (~₹31–32M in sales each), followed by North (~₹28M). East is the clear laggard at roughly ₹19M — about 40% lower than South/West.

**Why it matters:** A ~₹12–13M gap between the best and worst region on a ₹112.64M total sales base means East is significantly under-contributing relative to the other 3 regions.

**Business action:** Investigate why East underperforms — fewer stores in the region, weaker local demand, or under-marketing. Consider a targeted regional push (local promotions, staffing review) before the next quarter.

---

### 2. Store Performance Has a Wide Spread

**Observation:** Bengaluru Indiranagar is consistently the #1 store on both Sales and Profit. The Top 5 stores (Bengaluru Indiranagar, Mumbai Central, Delhi South Ex, Hyderabad Banjara Hills, Pune FC Road) are all metro/Tier-1 city stores. The Bottom 5 (Kochi MG Road, Kolkata Park Street, Bhubaneswar Patia, Patna Fraser Road, Ranchi Main Road) are all Tier-2/Tier-3 city stores.

**Why it matters:** This isn't random — there's a clear metro vs. non-metro performance pattern, suggesting the gap is structural (market size, footfall, brand awareness) rather than isolated to one bad store.

**Business action:** Don't treat bottom stores as failing — treat them as a different market segment needing a different playbook (localized product mix, smaller-format promotions) rather than the same strategy as metro stores.

---

### 3. Apparel Dominates, but Category Mix Is Broad

**Observation:** Apparel is the top category by both Sales (~₹26M) and Quantity sold (~20K units) — clearly the best-selling category by a wide margin. Electronics and Footwear are close to each other in second place (~₹22M each). Sports & Fitness and Home & Lifestyle are the weakest categories (~₹7M each).

**Why it matters:** Apparel and Footwear together likely account for a large share of both revenue and inventory movement, meaning stock and promotional planning should be weighted heavily toward these categories.

**Business action:** Prioritize inventory and marketing budget toward Apparel, Electronics, and Footwear. Re-evaluate whether Sports & Fitness and Home & Lifestyle deserve the same shelf space/investment given their comparatively low contribution.

---

### 4. Strong, Sharp Seasonal Spike in Q4

**Observation:** The Monthly Sales Trend is flat at roughly ₹9M/month from January through September, then jumps sharply from October, peaks around November (~₹11M), and eases slightly by December.

**Why it matters:** This is a clear festive-season effect (Diwali/year-end shopping in the Indian retail context) — nearly 9 months of the year perform at a similar baseline, while the last 3 months drive a disproportionate share of annual sales.

**Business action:** Concentrate inventory build-up, staffing, and marketing spend in September–October to be ready for the October–December surge, rather than spreading resources evenly across the year.

---

### 5. Return and Cancellation Rates Are Low and Healthy

**Observation:** Of 41,400 total orders: 38,604 (93.25%) are Completed, 2,003 (4.84%) are Returned, and 793 (~1.9%) are Cancelled — matching the donut chart split shown in the dashboard.

**Why it matters:** A ~5% return rate and ~2% cancellation rate are both within a normal, healthy range for retail — this is a positive signal, not a problem area.

**Business action:** No urgent fix needed here. Worth simply monitoring the Returned segment (₹56.6L in lost sales) monthly to catch any category or store where returns start trending upward.

---

### 6. Corporate Customers Contribute Far More Than Regular Customers

**Observation:** In the Customer Type breakdown, Corporate customers contribute roughly 73.8% of total sales (~₹83.1M), while Regular (individual) customers contribute only ~26.2% (~₹29.5M) — despite Corporate likely being a smaller customer count.

**Why it matters:** A small, high-value customer segment (Corporate/bulk buyers) is driving the majority of revenue. Losing even a few large Corporate accounts would hurt disproportionately.

**Business action:** Prioritize retention efforts (dedicated account support, bulk discounts, loyalty terms) for Corporate customers, since they represent concentrated revenue risk and opportunity.

---

### 7. High Customer Repeat Rate

**Observation:** Out of 5,200 total customers, roughly 5,000 are Repeat Customers — meaning the vast majority of the customer base has purchased more than once. With ~41,400 orders across ~5,200 customers, that's an average of ~8 orders per customer.

**Why it matters:** This indicates strong customer loyalty/retention already exists — the business isn't overly reliant on constantly acquiring new one-time buyers.

**Business action:** Since repeat purchasing is already strong, focus growth efforts on increasing average order value per repeat customer (cross-selling, bundling) rather than solely chasing new customer acquisition.

---

### 8. Data Quality Note: "Unknown Customer" in Top Customers List

**Observation:** The Top Customers by Sales chart shows an "Unknown Customer" entry with the single highest sales value, ahead of any named customer.

**Why it matters:** This means a meaningful number of transaction rows have a missing or blank `Customer_Name`. This is a data quality issue, not a real top customer.

**Business action:** Flag this for data cleaning — go back to the Clean Data sheet, filter for blank `Customer_Name` values, and either correct them or document them as a known data limitation before finalizing the report.
