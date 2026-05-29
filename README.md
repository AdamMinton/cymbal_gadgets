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

All changes have been validated against the Looker compiler and are 100% compliant.
