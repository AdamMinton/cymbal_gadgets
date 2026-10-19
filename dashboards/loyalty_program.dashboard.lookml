---
- dashboard: loyalty_program
  title: Cymbal Gadgets - Loyalty Program & Customer Spending Analysis
  preferred_viewer: dashboards-next
  crossfilter_enabled: true
  description: 'Executive Loyalty Program dashboard showing customer spending percentile thresholds (Top 1%, 5%, 10%), Revenue by Tier, Customer Counts by Tier, Top 10 Members per Tier, and strategic executive analysis.'
  layout: newspaper
  tabs:
  - name: ''
    label: ''
  elements:
  - name: executive_analysis_summary
    type: text
    title_text: "💎 Executive Summary: Customer Spending & Loyalty Tier Optimization"
    subtitle_text: "Percentile Threshold Analysis (Top 1%, Top 5%, Top 10%) & Legacy Tier Audit across 76,172 Customers ($1.13B Total Revenue)"
    body_text: |
      ### 1. Customer Spending Distribution & Revenue Thresholds
      Across **76,172 unique customers** and **955,786 transactions**, Cymbal Gadgets has generated **$1,125,525,377.42** in lifetime revenue (**$451,284,148.87** gross profit). Customer spending is right-skewed: the **mean spend is $14,776.10** while the **median (50th percentile) is $12,032.53** (ranging from **$17.66** to **$186,306.41**).

      | Spend Percentile Segment | LookML Percentile Threshold | Exact SQL (`PERCENTILE_CONT`) | Cumulative Customers | Cumulative Revenue | Cumulative Revenue Share | Mutually Exclusive Tier Band | Tier Customers | Tier Revenue | Avg Revenue / Customer |
      | :--- | :---: | :---: | :---: | :---: | :---: | :--- | :---: | :---: | :---: |
      | **Top 1% (99th Percentile)** | **$56,422.01** | **$56,427.12** | 762 | $52,613,572.74 | **4.67%** | **1. Top 1% (Platinum Elite)** | 762 (1.0%) | $52,613,572.74 | **$69,046.68** |
      | **Top 5% (95th Percentile)** | **$36,708.55** | **$36,707.70** | 3,809 | $185,955,784.77 | **16.52%** | **2. Top 5% (Gold: 1%–5%)** | 3,047 (4.0%) | $133,342,212.03 | **$43,761.80** |
      | **Top 10% (90th Percentile)** | **$28,991.77** | **$28,993.96** | 7,618 | $309,166,714.63 | **27.47%** | **3. Top 10% (Silver: 5%–10%)** | 3,809 (5.0%) | $123,210,929.86 | **$32,347.32** |
      | **Bottom 90% (< 90th Pct)** | **< $28,991.77** | **< $28,993.96** | 76,172 | $1,125,525,377.42 | **100.00%** | **4. Bottom 90% (Bronze)** | 68,554 (90.0%) | $816,358,662.79 | **$11,908.26** |

      ---

      ### 2. Strategic Executive Finding: Legacy Loyalty Tiers Are Misaligned with Customer Spend
      * **High-Value VIPs Stuck in Lower Tiers:** Legacy `loyaltytier` assignments correlate with *transaction count* rather than *total revenue*. Consequently, **358 of our 762 Top 1% spenders (47.0%)** are NOT in Platinum—including **58 Top 1% VIPs in Bronze ($4.65M revenue)** and **62 in Silver ($4.49M revenue)**. Most notably, our **#1 highest-spending customer overall, Jacob Cruz ($186,306.41 across 6 high-ticket orders)**, is currently classified in **Bronze**, and our **#2 and #3 customers, Yves Henry ($171,824.69) and Scott Jones ($152,942.60)**, are in **Silver**.
      * **Benefit Dilution in Legacy Platinum:** Conversely, **1,604 of the 3,865 legacy Platinum members (41.5%)** fall into the **Bottom 90%** of customer spend (`< $28,992`, with spend as low as **$1,278.26**).
      * **Recommendation & Technical Validation:** Transition loyalty qualification to the reusable **Cascading Native Derived Tables (`customer_spending_ndt` & `customer_loyalty_tiers_ndt`)** built in LookML. We validated Looker's native `type: percentile` (`APPROX_QUANTILES`) measures against exact BigQuery `PERCENTILE_CONT` window functions—confirming agreement within `< 0.01%` ($5 on $56.4K).
    row: 0
    col: 0
    width: 24
    height: 7
    tab_name: ''

  - title: Total Customer Revenue
    name: Total Customer Revenue
    model: cymbal_gadgets
    explore: customer_spending_ndt
    type: single_value
    fields: [customer_spending_ndt.total_lifetime_revenue]
    limit: 500
    listen:
      Assigned Loyalty Tier: customer_spending_ndt.loyaltytier
      Spend Percentile Tier: customer_spending_ndt.spend_percentile_tier
      Customer Country: customer_spending_ndt.customer_country
    row: 7
    col: 0
    width: 4
    height: 3
    tab_name: ''

  - title: Total Unique Customers
    name: Total Unique Customers
    model: cymbal_gadgets
    explore: customer_spending_ndt
    type: single_value
    fields: [customer_spending_ndt.count]
    limit: 500
    listen:
      Assigned Loyalty Tier: customer_spending_ndt.loyaltytier
      Spend Percentile Tier: customer_spending_ndt.spend_percentile_tier
      Customer Country: customer_spending_ndt.customer_country
    row: 7
    col: 4
    width: 4
    height: 3
    tab_name: ''

  - title: Avg Revenue per Customer
    name: Avg Revenue per Customer
    model: cymbal_gadgets
    explore: customer_spending_ndt
    type: single_value
    fields: [customer_spending_ndt.average_lifetime_revenue]
    limit: 500
    listen:
      Assigned Loyalty Tier: customer_spending_ndt.loyaltytier
      Spend Percentile Tier: customer_spending_ndt.spend_percentile_tier
      Customer Country: customer_spending_ndt.customer_country
    row: 7
    col: 8
    width: 4
    height: 3
    tab_name: ''

  - title: Top 1% Revenue Threshold (99th Pct)
    name: Top 1% Revenue Threshold (99th Pct)
    model: cymbal_gadgets
    explore: customer_spending_ndt
    type: single_value
    fields: [customer_spending_ndt.revenue_threshold_top_1_pct]
    limit: 500
    listen:
      Assigned Loyalty Tier: customer_spending_ndt.loyaltytier
      Spend Percentile Tier: customer_spending_ndt.spend_percentile_tier
      Customer Country: customer_spending_ndt.customer_country
    row: 7
    col: 12
    width: 4
    height: 3
    tab_name: ''

  - title: Top 5% Revenue Threshold (95th Pct)
    name: Top 5% Revenue Threshold (95th Pct)
    model: cymbal_gadgets
    explore: customer_spending_ndt
    type: single_value
    fields: [customer_spending_ndt.revenue_threshold_top_5_pct]
    limit: 500
    listen:
      Assigned Loyalty Tier: customer_spending_ndt.loyaltytier
      Spend Percentile Tier: customer_spending_ndt.spend_percentile_tier
      Customer Country: customer_spending_ndt.customer_country
    row: 7
    col: 16
    width: 4
    height: 3
    tab_name: ''

  - title: Top 10% Revenue Threshold (90th Pct)
    name: Top 10% Revenue Threshold (90th Pct)
    model: cymbal_gadgets
    explore: customer_spending_ndt
    type: single_value
    fields: [customer_spending_ndt.revenue_threshold_top_10_pct]
    limit: 500
    listen:
      Assigned Loyalty Tier: customer_spending_ndt.loyaltytier
      Spend Percentile Tier: customer_spending_ndt.spend_percentile_tier
      Customer Country: customer_spending_ndt.customer_country
    row: 7
    col: 20
    width: 4
    height: 3
    tab_name: ''

  - title: Revenue by Spend Percentile Tier
    name: Revenue by Spend Percentile Tier
    model: cymbal_gadgets
    explore: customer_spending_ndt
    type: looker_column
    fields: [customer_spending_ndt.spend_percentile_tier, customer_spending_ndt.total_lifetime_revenue]
    sorts: [customer_spending_ndt.spend_percentile_tier asc]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    show_value_labels: true
    defaults_version: 1
    listen:
      Assigned Loyalty Tier: customer_spending_ndt.loyaltytier
      Spend Percentile Tier: customer_spending_ndt.spend_percentile_tier
      Customer Country: customer_spending_ndt.customer_country
    row: 10
    col: 0
    width: 8
    height: 7
    tab_name: ''

  - title: Customer Counts by Spend Percentile Tier
    name: Customer Counts by Spend Percentile Tier
    model: cymbal_gadgets
    explore: customer_spending_ndt
    type: looker_bar
    fields: [customer_spending_ndt.spend_percentile_tier, customer_spending_ndt.count]
    sorts: [customer_spending_ndt.spend_percentile_tier asc]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    show_value_labels: true
    defaults_version: 1
    listen:
      Assigned Loyalty Tier: customer_spending_ndt.loyaltytier
      Spend Percentile Tier: customer_spending_ndt.spend_percentile_tier
      Customer Country: customer_spending_ndt.customer_country
    row: 10
    col: 8
    width: 8
    height: 7
    tab_name: ''

  - title: Spend Percentile Tier Breakdown (Counts, Revenue & Thresholds)
    name: Spend Percentile Tier Breakdown (Counts, Revenue & Thresholds)
    model: cymbal_gadgets
    explore: customer_spending_ndt
    type: looker_grid
    fields: [
      customer_spending_ndt.spend_percentile_tier,
      customer_spending_ndt.count,
      customer_spending_ndt.total_lifetime_revenue,
      customer_spending_ndt.average_lifetime_revenue,
      customer_spending_ndt.min_lifetime_revenue,
      customer_spending_ndt.max_lifetime_revenue
    ]
    sorts: [customer_spending_ndt.spend_percentile_tier asc]
    limit: 500
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    enable_conditional_formatting: false
    defaults_version: 1
    listen:
      Assigned Loyalty Tier: customer_spending_ndt.loyaltytier
      Spend Percentile Tier: customer_spending_ndt.spend_percentile_tier
      Customer Country: customer_spending_ndt.customer_country
    row: 10
    col: 16
    width: 8
    height: 7
    tab_name: ''

  - title: Revenue by Assigned Loyalty Tier
    name: Revenue by Assigned Loyalty Tier
    model: cymbal_gadgets
    explore: customer_spending_ndt
    type: looker_column
    fields: [customer_spending_ndt.loyaltytier, customer_spending_ndt.total_lifetime_revenue]
    sorts: [customer_spending_ndt.total_lifetime_revenue desc]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    show_value_labels: true
    defaults_version: 1
    listen:
      Assigned Loyalty Tier: customer_spending_ndt.loyaltytier
      Spend Percentile Tier: customer_spending_ndt.spend_percentile_tier
      Customer Country: customer_spending_ndt.customer_country
    row: 17
    col: 0
    width: 8
    height: 7
    tab_name: ''

  - title: Customer Counts by Assigned Loyalty Tier
    name: Customer Counts by Assigned Loyalty Tier
    model: cymbal_gadgets
    explore: customer_spending_ndt
    type: looker_bar
    fields: [customer_spending_ndt.loyaltytier, customer_spending_ndt.count]
    sorts: [customer_spending_ndt.count desc]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    show_value_labels: true
    defaults_version: 1
    listen:
      Assigned Loyalty Tier: customer_spending_ndt.loyaltytier
      Spend Percentile Tier: customer_spending_ndt.spend_percentile_tier
      Customer Country: customer_spending_ndt.customer_country
    row: 17
    col: 8
    width: 8
    height: 7
    tab_name: ''

  - title: Tier Alignment Audit (Assigned Tier vs. Spend Percentile Tier)
    name: tier_alignment_audit
    model: cymbal_gadgets
    explore: customer_spending_ndt
    type: looker_grid
    fields: [
      customer_spending_ndt.loyaltytier,
      customer_spending_ndt.spend_percentile_tier,
      customer_spending_ndt.count,
      customer_spending_ndt.total_lifetime_revenue
    ]
    pivots: [customer_spending_ndt.spend_percentile_tier]
    sorts: [customer_spending_ndt.spend_percentile_tier asc, customer_spending_ndt.total_lifetime_revenue desc 0]
    limit: 500
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    defaults_version: 1
    listen:
      Assigned Loyalty Tier: customer_spending_ndt.loyaltytier
      Spend Percentile Tier: customer_spending_ndt.spend_percentile_tier
      Customer Country: customer_spending_ndt.customer_country
    row: 17
    col: 16
    width: 8
    height: 7
    tab_name: ''

  - title: "Top 10 Members: Top 1% Spend Tier (Platinum Elite >= $56.4K)"
    name: "Top 10 Members: Top 1% Spend Tier"
    model: cymbal_gadgets
    explore: customer_spending_ndt
    type: looker_grid
    fields: [
      customer_loyalty_tiers_ndt.spend_percentile_tier_rank,
      customer_loyalty_tiers_ndt.customerid,
      customer_loyalty_tiers_ndt.customer_name,
      customer_loyalty_tiers_ndt.customer_country,
      customer_loyalty_tiers_ndt.loyaltytier,
      customer_loyalty_tiers_ndt.lifetime_transactions,
      customer_loyalty_tiers_ndt.lifetime_revenue,
      customer_loyalty_tiers_ndt.lifetime_gross_profit
    ]
    filters:
      customer_loyalty_tiers_ndt.spend_percentile_tier: "1. Top 1% (Platinum)"
      customer_loyalty_tiers_ndt.is_top_10_in_spend_tier: "Yes"
    sorts: [customer_loyalty_tiers_ndt.spend_percentile_tier_rank asc]
    limit: 10
    show_view_names: false
    show_row_numbers: false
    size_to_fit: true
    table_theme: white
    defaults_version: 1
    listen:
      Customer Country: customer_spending_ndt.customer_country
    row: 24
    col: 0
    width: 12
    height: 7
    tab_name: ''

  - title: "Top 10 Members: Top 5% Spend Tier (Gold $36.7K - $56.4K)"
    name: "Top 10 Members: Top 5% Spend Tier"
    model: cymbal_gadgets
    explore: customer_spending_ndt
    type: looker_grid
    fields: [
      customer_loyalty_tiers_ndt.spend_percentile_tier_rank,
      customer_loyalty_tiers_ndt.customerid,
      customer_loyalty_tiers_ndt.customer_name,
      customer_loyalty_tiers_ndt.customer_country,
      customer_loyalty_tiers_ndt.loyaltytier,
      customer_loyalty_tiers_ndt.lifetime_transactions,
      customer_loyalty_tiers_ndt.lifetime_revenue,
      customer_loyalty_tiers_ndt.lifetime_gross_profit
    ]
    filters:
      customer_loyalty_tiers_ndt.spend_percentile_tier: "2. Top 5% (Gold)"
      customer_loyalty_tiers_ndt.is_top_10_in_spend_tier: "Yes"
    sorts: [customer_loyalty_tiers_ndt.spend_percentile_tier_rank asc]
    limit: 10
    show_view_names: false
    show_row_numbers: false
    size_to_fit: true
    table_theme: white
    defaults_version: 1
    listen:
      Customer Country: customer_spending_ndt.customer_country
    row: 24
    col: 12
    width: 12
    height: 7
    tab_name: ''

  - title: "Top 10 Members: Top 10% Spend Tier (Silver $29.0K - $36.7K)"
    name: "Top 10 Members: Top 10% Spend Tier"
    model: cymbal_gadgets
    explore: customer_spending_ndt
    type: looker_grid
    fields: [
      customer_loyalty_tiers_ndt.spend_percentile_tier_rank,
      customer_loyalty_tiers_ndt.customerid,
      customer_loyalty_tiers_ndt.customer_name,
      customer_loyalty_tiers_ndt.customer_country,
      customer_loyalty_tiers_ndt.loyaltytier,
      customer_loyalty_tiers_ndt.lifetime_transactions,
      customer_loyalty_tiers_ndt.lifetime_revenue,
      customer_loyalty_tiers_ndt.lifetime_gross_profit
    ]
    filters:
      customer_loyalty_tiers_ndt.spend_percentile_tier: "3. Top 10% (Silver)"
      customer_loyalty_tiers_ndt.is_top_10_in_spend_tier: "Yes"
    sorts: [customer_loyalty_tiers_ndt.spend_percentile_tier_rank asc]
    limit: 10
    show_view_names: false
    show_row_numbers: false
    size_to_fit: true
    table_theme: white
    defaults_version: 1
    listen:
      Customer Country: customer_spending_ndt.customer_country
    row: 31
    col: 0
    width: 12
    height: 7
    tab_name: ''

  - title: "Top 10 Members: Bottom 90% Spend Tier (Bronze < $29.0K)"
    name: "Top 10 Members: Bottom 90% Spend Tier"
    model: cymbal_gadgets
    explore: customer_spending_ndt
    type: looker_grid
    fields: [
      customer_loyalty_tiers_ndt.spend_percentile_tier_rank,
      customer_loyalty_tiers_ndt.customerid,
      customer_loyalty_tiers_ndt.customer_name,
      customer_loyalty_tiers_ndt.customer_country,
      customer_loyalty_tiers_ndt.loyaltytier,
      customer_loyalty_tiers_ndt.lifetime_transactions,
      customer_loyalty_tiers_ndt.lifetime_revenue,
      customer_loyalty_tiers_ndt.lifetime_gross_profit
    ]
    filters:
      customer_loyalty_tiers_ndt.spend_percentile_tier: "4. Bottom 90% (Bronze)"
      customer_loyalty_tiers_ndt.is_top_10_in_spend_tier: "Yes"
    sorts: [customer_loyalty_tiers_ndt.spend_percentile_tier_rank asc]
    limit: 10
    show_view_names: false
    show_row_numbers: false
    size_to_fit: true
    table_theme: white
    defaults_version: 1
    listen:
      Customer Country: customer_spending_ndt.customer_country
    row: 31
    col: 12
    width: 12
    height: 7
    tab_name: ''

  - title: "Top 10 Members for Each Assigned Loyalty Tier (Platinum, Gold, Silver, Bronze)"
    name: "Top 10 Members for Each Assigned Loyalty Tier"
    model: cymbal_gadgets
    explore: customer_spending_ndt
    type: looker_grid
    fields: [
      customer_spending_ndt.loyaltytier,
      customer_spending_ndt.existing_tier_spend_rank,
      customer_spending_ndt.overall_spend_rank,
      customer_spending_ndt.customerid,
      customer_spending_ndt.customer_name,
      customer_spending_ndt.customer_country,
      customer_spending_ndt.spend_percentile_tier,
      customer_spending_ndt.lifetime_transactions,
      customer_spending_ndt.lifetime_revenue,
      customer_spending_ndt.lifetime_gross_profit
    ]
    filters:
      customer_spending_ndt.existing_tier_spend_rank: "<=10"
    sorts: [customer_spending_ndt.loyaltytier asc, customer_spending_ndt.existing_tier_spend_rank asc]
    limit: 40
    show_view_names: false
    show_row_numbers: false
    size_to_fit: true
    table_theme: white
    defaults_version: 1
    listen:
      Assigned Loyalty Tier: customer_spending_ndt.loyaltytier
      Spend Percentile Tier: customer_spending_ndt.spend_percentile_tier
      Customer Country: customer_spending_ndt.customer_country
    row: 38
    col: 0
    width: 15
    height: 9
    tab_name: ''

  - title: "Threshold & Share Validation (LookML Percentile vs. Exact SQL)"
    name: "Threshold & Share Validation"
    model: cymbal_gadgets
    explore: customer_spending_ndt
    type: looker_grid
    fields: [
      customer_spending_ndt.revenue_threshold_top_1_pct,
      customer_spending_ndt.exact_p99_revenue_threshold,
      customer_spending_ndt.top_1_pct_revenue_share,
      customer_spending_ndt.revenue_threshold_top_5_pct,
      customer_spending_ndt.exact_p95_revenue_threshold,
      customer_spending_ndt.top_5_pct_revenue_share,
      customer_spending_ndt.revenue_threshold_top_10_pct,
      customer_spending_ndt.exact_p90_revenue_threshold,
      customer_spending_ndt.top_10_pct_revenue_share
    ]
    limit: 10
    show_view_names: false
    show_row_numbers: false
    transpose: true
    size_to_fit: true
    table_theme: white
    defaults_version: 1
    listen:
      Customer Country: customer_spending_ndt.customer_country
    row: 38
    col: 15
    width: 9
    height: 9
    tab_name: ''

  filters:
  - name: Spend Percentile Tier
    title: Spend Percentile Tier
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: checkboxes
      display: popover
    model: cymbal_gadgets
    explore: customer_spending_ndt
    listens_to_filters: []
    field: customer_spending_ndt.spend_percentile_tier

  - name: Assigned Loyalty Tier
    title: Assigned Loyalty Tier
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: checkboxes
      display: popover
    model: cymbal_gadgets
    explore: customer_spending_ndt
    listens_to_filters: []
    field: customer_spending_ndt.loyaltytier

  - name: Customer Country
    title: Customer Country
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: cymbal_gadgets
    explore: customer_spending_ndt
    listens_to_filters: []
    field: customer_spending_ndt.customer_country
