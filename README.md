# Cymbal Gadgets: LookML Financial Modeling & Audit

This repository contains the LookML model and views for the **Cymbal Gadgets** dataset. As part of a financial audit and data modeling review, the core financial calculations have been restructured and corrected to align with standard financial accounting and auditing guidelines (GAAP/IFRS).

## Financial Model & Definitions

The following table summarizes how the financial metrics are defined in the schema and how they have been implemented in LookML:

| Metric | Business Definition | Mathematical Formula | LookML Field |
| :--- | :--- | :--- | :--- |
| **Gross Revenue** | Total sales value at list price before discounts, tax, or shipping. | `product_master_price * quantity` | `transactions.gross_revenue` |
| **Net Revenue** | Sales revenue retained by the company after customer discounts. | `gross_revenue - discountamount` | `transactions.net_revenue` |
| **COGS** | Direct Cost of Goods Sold (inventory cost to acquire/make). | `product_cost * quantity` | `transactions.cogs` |
| **Gross Profit** | Core profitability of sold products before operating expenses. | `net_revenue - COGS` | `transactions.gross_profit` |
| **Gross Margin %** | Gross profitability expressed as a percentage of net revenue. | `gross_profit / net_revenue` | `transactions.gross_margin_percentage` |
| **Lost Revenue** | Revenue from online orders that occurred >30 days ago but have null shipment status. | `net_revenue` (where channel is Online, age > 30 days, and shipment status is null) | `transactions.lost_revenue` / `transactions.total_lost_revenue` |

---

## Audit Finding & Correction

### The Schema Discrepancy
In the original database schema, `totalprice` is defined as:
```
totalprice = (product_master_price * quantity) - discountamount + taxamount + shippingcost
```
However, the original LookML implementation calculated **Gross Profit** as:
```
gross_profit = totalprice - (product_cost * quantity)
```

### Why This Was Financially Incorrect (Audit Finding)
1. **Sales Tax Inclusion:** Sales tax (`taxamount`) is a liability collected on behalf of the government and must be excluded from both Revenue and Profit. Including it inflated Gross Profit.
2. **Shipping Cost Inclusion:** Shipping charges (`shippingcost`) represent logistics/fulfillment fees. Including them directly in product gross profit without matching them against shipping expenses distorted product margin metrics.
3. **Discounts Treatment:** The original formula deducted discounts but did not cleanly isolate **Gross Revenue** vs. **Net Revenue**, which is critical for analyzing pricing and promotion efficiency.

### Resolution
The LookML fields in `views/transactions.view.lkml` were corrected to:
1. Define **Gross Revenue** as `product_master_price * quantity`.
2. Define **Net Revenue** as `gross_revenue - discountamount`.
3. Define **COGS** as `product_cost * quantity`.
4. Define **Gross Profit** cleanly as `net_revenue - cogs`.
5. Update **Gross Margin %** to divide `total_gross_profit` by `total_net_revenue`.

---

## Lost Revenue Tracking

### Scope & Criteria Definition
The requirement to track **Lost Revenue** is defined as revenue from transactions that occurred more than 30 days ago but have a null shipment status.

During development, we identified an important architectural distinction:
* **In-Store Sales:** In-Store sales are completed physically and immediately at checkout. They never undergo shipping, and therefore their `shipment_status` in the database is always `NULL`.
* **Online Sales:** Online sales undergo fulfillment and shipping. A `NULL` shipment status on an Online transaction older than 30 days indicates a critical failure or delay in the fulfillment pipeline.

If we applied the rule literally without filtering by sales channel, all historical In-Store sales (comprising **322,440 transactions** and over **$377.9M in revenue**) would be incorrectly flagged as "Lost Revenue".

### Implementation
To prevent this distortion, we aligned with business logic to **restrict the metric strictly to Online sales**:
1. Added a `lost_revenue` dimension that checks:
   * Sales channel is `'Online'`
   * Transaction date is older than 30 days (`DATE_DIFF(CURRENT_DATE(), transaction_date, DAY) > 30`)
   * Shipment status is `NULL`
2. Added a `total_lost_revenue` measure that sums the dimension, formatted consistently as currency (`usd_0`).
3. Fully integrated the metrics into the main `transactions` view with compiler validation.

