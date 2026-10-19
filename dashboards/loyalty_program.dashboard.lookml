---
- dashboard: loyalty_program
  title: Cymbal Gadgets - Loyalty Program & Customer Spending Analysis
  preferred_viewer: dashboards-next
  crossfilter_enabled: true
  description: "Executive analysis of customer lifetime spending, revenue thresholds for the Top 1%, Top 5%, and Top 10% of customers, tier breakdowns, and Top 10 members per tier."
  layout: newspaper
  elements:
  - name: executive_analysis_summary
    type: text
    title_text: "💎 Executive Analysis: Customer Spending Thresholds & Loyalty Program Strategy"
    subtitle_text: "Data-Driven Revenue Thresholds (Top 1%, Top 5%, Top 10%) & Tier Alignment Findings"
    body_text: |
      ### 1. Executive Summary & Revenue Thresholds
      Across **76,177 unique customers** and **956,706 transactions**, Cymbal Gadgets has generated **$1,126,657,694 ($1.13B)** in cumulative revenue, with an **Average Customer Lifetime Revenue of $14,790.00** and a **Median of $12,042.34**. Using our reusable **Native Derived Tables (`customer_spending` and `customer_loyalty_tiers`)** and LookML percentile measures, we established the exact lifetime revenue thresholds required to enter our top spending cohorts:

      * **Top 1% Threshold (99th Percentile — Proposed Platinum VIP):** **$56,517.66** *(exact Rank #762 boundary: $56,505.70)* — **762 customers** generating **$52,669,303** (**4.67%** of total revenue; **$69,119.82** avg spend/customer).
      * **Top 5% Threshold (95th Percentile — Proposed Gold Tier):** **$36,751.73** *(Rank #3,809 boundary)* — **3,809 cumulative customers** generating **$186,091,730** (**16.52%** of total revenue). The **95th–99th percentile band** alone has **3,047 customers** generating **$133,422,427** (**11.84%** of total revenue; **$43,788.13** avg spend/customer).
      * **Top 10% Threshold (90th Percentile — Proposed Silver Tier):** **$29,007.36** *(exact Rank #7,618 boundary: $29,009.83)* — **7,618 cumulative customers** generating **$309,421,192** (**27.46%** of total revenue). The **90th–95th percentile band** has **3,809 customers** generating **$123,329,462** (**10.95%** of total revenue; **$32,378.44** avg spend/customer).
      * **Bottom 90% (<90th Percentile — Proposed Bronze Tier):** **<$29,009.83** — **68,559 customers** generating **$817,236,502** (**72.54%** of total revenue; **$11,920.19** avg spend/customer).

      ---
      ### 2. Key Strategic Finding: Legacy Loyalty Tier Misalignment
      Cross-tabulating our **Current Loyalty Tiers (`Platinum`, `Gold`, `Silver`, `Bronze`)** against actual customer spending reveals a critical retention risk and optimization opportunity:
      * **Unrecognized VIPs in Lower Tiers:** Only **52.8% (402 of 762)** of our **Top 1% spenders** are currently in **Platinum**. **60 Top 1% customers** ($4.78M revenue)—including our **#1 highest-spending customer overall, Jacob Cruz ($186,306.41)**, and **#4 Mark Wallace ($146,255.14)**—are currently in **Bronze**, while **61 Top 1% customers** ($4.44M revenue)—including **#2 Yves Henry ($171,824.69)** and **#3 Scott Jones ($152,942.60)**—are in **Silver**.
      * **Tier Dilution in Upper Tiers:** Conversely, **41.4% (1,601 of 3,865)** of current **Platinum** members and **69.6% (5,272 of 7,574)** of current **Gold** members fall into the **Bottom 90%** of lifetime spenders (<$29,010).
      * **Executive Recommendation:** Re-anchor Loyalty Program tier qualification to the empirical percentile revenue thresholds (**$56.5K+ for Top 1%**, **$36.8K+ for Top 5%**, **$29.0K+ for Top 10%**) and immediately fast-track the **121 Top 1% spenders currently in Bronze/Silver** to top-tier status to protect high-margin VIP revenue.
    row: 0
    col: 0
    width: 24
    height: 7

  - title: Top 1% Revenue Threshold (99th Percentile)
    name: top_1_pct_threshold_kpi
    model: cymbal_gadgets
    explore: customer_spending
    type: single_value
    fields: [customer_spending.top_1_pct_revenue_threshold]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    defaults_version: 1
    listen:
      Current Loyalty Tier: customer_spending.loyaltytier
      Spending Tier: customer_spending.spending_tier
      Customer Country: customer_spending.customer_country
    row: 7
    col: 0
    width: 4
    height: 4

  - title: Top 5% Revenue Threshold (95th Percentile)
    name: top_5_pct_threshold_kpi
    model: cymbal_gadgets
    explore: customer_spending
    type: single_value
    fields: [customer_spending.top_5_pct_revenue_threshold]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    defaults_version: 1
    listen:
      Current Loyalty Tier: customer_spending.loyaltytier
      Spending Tier: customer_spending.spending_tier
      Customer Country: customer_spending.customer_country
    row: 7
    col: 4
    width: 4
    height: 4

  - title: Top 10% Revenue Threshold (90th Percentile)
    name: top_10_pct_threshold_kpi
    model: cymbal_gadgets
    explore: customer_spending
    type: single_value
    fields: [customer_spending.top_10_pct_revenue_threshold]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    defaults_version: 1
    listen:
      Current Loyalty Tier: customer_spending.loyaltytier
      Spending Tier: customer_spending.spending_tier
      Customer Country: customer_spending.customer_country
    row: 7
    col: 8
    width: 4
    height: 4

  - title: Total Unique Customers
    name: total_customers_kpi
    model: cymbal_gadgets
    explore: customer_spending
    type: single_value
    fields: [customer_spending.count_customers]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    defaults_version: 1
    listen:
      Current Loyalty Tier: customer_spending.loyaltytier
      Spending Tier: customer_spending.spending_tier
      Customer Country: customer_spending.customer_country
    row: 7
    col: 12
    width: 4
    height: 4

  - title: Total Customer Revenue
    name: total_revenue_kpi
    model: cymbal_gadgets
    explore: customer_spending
    type: single_value
    fields: [customer_spending.total_customer_revenue]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    defaults_version: 1
    listen:
      Current Loyalty Tier: customer_spending.loyaltytier
      Spending Tier: customer_spending.spending_tier
      Customer Country: customer_spending.customer_country
    row: 7
    col: 16
    width: 4
    height: 4

  - title: Avg Lifetime Revenue per Customer
    name: avg_customer_ltv_kpi
    model: cymbal_gadgets
    explore: customer_spending
    type: single_value
    fields: [customer_spending.average_customer_lifetime_revenue]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    defaults_version: 1
    listen:
      Current Loyalty Tier: customer_spending.loyaltytier
      Spending Tier: customer_spending.spending_tier
      Customer Country: customer_spending.customer_country
    row: 7
    col: 20
    width: 4
    height: 4

  - title: Revenue by Spending Tier (Percentile Cohorts)
    name: revenue_by_spending_tier
    model: cymbal_gadgets
    explore: customer_spending
    type: looker_column
    fields: [customer_spending.spending_tier, customer_spending.total_customer_revenue, customer_spending.average_customer_lifetime_revenue]
    sorts: [customer_spending.spending_tier asc]
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
      Current Loyalty Tier: customer_spending.loyaltytier
      Spending Tier: customer_spending.spending_tier
      Customer Country: customer_spending.customer_country
    row: 11
    col: 0
    width: 8
    height: 8

  - title: Customer Counts by Spending Tier (Percentile Cohorts)
    name: customer_counts_by_spending_tier
    model: cymbal_gadgets
    explore: customer_spending
    type: looker_bar
    fields: [customer_spending.spending_tier, customer_spending.count_customers]
    sorts: [customer_spending.spending_tier asc]
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
      Current Loyalty Tier: customer_spending.loyaltytier
      Spending Tier: customer_spending.spending_tier
      Customer Country: customer_spending.customer_country
    row: 11
    col: 8
    width: 8
    height: 8

  - title: Spending Tier Summary (Counts, Revenue & Thresholds)
    name: spending_tier_summary_table
    model: cymbal_gadgets
    explore: customer_spending
    type: looker_grid
    fields: [
      customer_spending.spending_tier,
      customer_spending.count_customers,
      customer_spending.total_customer_revenue,
      customer_spending.average_customer_lifetime_revenue,
      customer_spending.min_customer_lifetime_revenue,
      customer_spending.max_customer_lifetime_revenue
    ]
    sorts: [customer_spending.spending_tier asc]
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
      Current Loyalty Tier: customer_spending.loyaltytier
      Spending Tier: customer_spending.spending_tier
      Customer Country: customer_spending.customer_country
    row: 11
    col: 16
    width: 8
    height: 8

  - title: Revenue by Current Loyalty Tier (Platinum, Gold, Silver, Bronze)
    name: revenue_by_current_loyalty_tier
    model: cymbal_gadgets
    explore: customer_spending
    type: looker_column
    fields: [customer_spending.loyaltytier, customer_spending.total_customer_revenue, customer_spending.average_customer_lifetime_revenue]
    sorts: [customer_spending.total_customer_revenue desc]
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
      Current Loyalty Tier: customer_spending.loyaltytier
      Spending Tier: customer_spending.spending_tier
      Customer Country: customer_spending.customer_country
    row: 19
    col: 0
    width: 8
    height: 8

  - title: Customer Counts by Current Loyalty Tier
    name: customer_counts_by_current_loyalty_tier
    model: cymbal_gadgets
    explore: customer_spending
    type: looker_pie
    fields: [customer_spending.loyaltytier, customer_spending.count_customers]
    sorts: [customer_spending.count_customers desc]
    limit: 500
    value_labels: legend
    label_type: labPer
    defaults_version: 1
    listen:
      Current Loyalty Tier: customer_spending.loyaltytier
      Spending Tier: customer_spending.spending_tier
      Customer Country: customer_spending.customer_country
    row: 19
    col: 8
    width: 8
    height: 8

  - title: Loyalty Tier Alignment Matrix (Spending Tier vs. Current Loyalty Tier)
    name: tier_alignment_matrix
    model: cymbal_gadgets
    explore: customer_spending
    type: looker_grid
    fields: [
      customer_spending.spending_tier,
      customer_spending.loyaltytier,
      customer_spending.count_customers,
      customer_spending.total_customer_revenue
    ]
    pivots: [customer_spending.loyaltytier]
    sorts: [customer_spending.spending_tier asc, customer_spending.loyaltytier]
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
      Current Loyalty Tier: customer_spending.loyaltytier
      Spending Tier: customer_spending.spending_tier
      Customer Country: customer_spending.customer_country
    row: 19
    col: 16
    width: 8
    height: 8

  - title: "Top 10 Members: Top 1% Tier (99th+ Percentile | >= $56.5K)"
    name: top_10_members_top_1_pct
    model: cymbal_gadgets
    explore: customer_spending
    type: looker_grid
    fields: [
      customer_loyalty_tiers.spending_tier_rank,
      customer_spending.customerid,
      customer_spending.customer_name,
      customer_spending.loyaltytier,
      customer_spending.customer_country,
      customer_spending.customer_lifetime_transactions,
      customer_spending.total_customer_revenue,
      customer_spending.total_customer_gross_profit
    ]
    filters:
      customer_spending.spending_tier: "1. Top 1% (99th+ Percentile)"
      customer_loyalty_tiers.is_top_10_in_spending_tier: "Yes"
    sorts: [customer_loyalty_tiers.spending_tier_rank asc]
    limit: 10
    show_view_names: false
    show_row_numbers: false
    size_to_fit: true
    table_theme: white
    defaults_version: 1
    listen:
      Customer Country: customer_spending.customer_country
    row: 27
    col: 0
    width: 12
    height: 8

  - title: "Top 10 Members: Top 5% Tier (95th-99th Percentile | $36.8K - $56.5K)"
    name: top_10_members_top_5_pct
    model: cymbal_gadgets
    explore: customer_spending
    type: looker_grid
    fields: [
      customer_loyalty_tiers.spending_tier_rank,
      customer_spending.customerid,
      customer_spending.customer_name,
      customer_spending.loyaltytier,
      customer_spending.customer_country,
      customer_spending.customer_lifetime_transactions,
      customer_spending.total_customer_revenue,
      customer_spending.total_customer_gross_profit
    ]
    filters:
      customer_spending.spending_tier: "2. Top 5% (95th-99th Percentile)"
      customer_loyalty_tiers.is_top_10_in_spending_tier: "Yes"
    sorts: [customer_loyalty_tiers.spending_tier_rank asc]
    limit: 10
    show_view_names: false
    show_row_numbers: false
    size_to_fit: true
    table_theme: white
    defaults_version: 1
    listen:
      Customer Country: customer_spending.customer_country
    row: 27
    col: 12
    width: 12
    height: 8

  - title: "Top 10 Members: Top 10% Tier (90th-95th Percentile | $29.0K - $36.8K)"
    name: top_10_members_top_10_pct
    model: cymbal_gadgets
    explore: customer_spending
    type: looker_grid
    fields: [
      customer_loyalty_tiers.spending_tier_rank,
      customer_spending.customerid,
      customer_spending.customer_name,
      customer_spending.loyaltytier,
      customer_spending.customer_country,
      customer_spending.customer_lifetime_transactions,
      customer_spending.total_customer_revenue,
      customer_spending.total_customer_gross_profit
    ]
    filters:
      customer_spending.spending_tier: "3. Top 10% (90th-95th Percentile)"
      customer_loyalty_tiers.is_top_10_in_spending_tier: "Yes"
    sorts: [customer_loyalty_tiers.spending_tier_rank asc]
    limit: 10
    show_view_names: false
    show_row_numbers: false
    size_to_fit: true
    table_theme: white
    defaults_version: 1
    listen:
      Customer Country: customer_spending.customer_country
    row: 35
    col: 0
    width: 12
    height: 8

  - title: "Top 10 Members: Bottom 90% Tier (<90th Percentile | < $29.0K)"
    name: top_10_members_bottom_90_pct
    model: cymbal_gadgets
    explore: customer_spending
    type: looker_grid
    fields: [
      customer_loyalty_tiers.spending_tier_rank,
      customer_spending.customerid,
      customer_spending.customer_name,
      customer_spending.loyaltytier,
      customer_spending.customer_country,
      customer_spending.customer_lifetime_transactions,
      customer_spending.total_customer_revenue,
      customer_spending.total_customer_gross_profit
    ]
    filters:
      customer_spending.spending_tier: "4. Bottom 90% (<90th Percentile)"
      customer_loyalty_tiers.is_top_10_in_spending_tier: "Yes"
    sorts: [customer_loyalty_tiers.spending_tier_rank asc]
    limit: 10
    show_view_names: false
    show_row_numbers: false
    size_to_fit: true
    table_theme: white
    defaults_version: 1
    listen:
      Customer Country: customer_spending.customer_country
    row: 35
    col: 12
    width: 12
    height: 8

  - title: "Consolidated Directory: Top 10 Members for Each Spending Tier"
    name: top_10_members_all_spending_tiers
    model: cymbal_gadgets
    explore: customer_spending
    type: looker_grid
    fields: [
      customer_spending.spending_tier,
      customer_loyalty_tiers.spending_tier_rank,
      customer_spending.spending_rank,
      customer_spending.customerid,
      customer_spending.customer_name,
      customer_spending.loyaltytier,
      customer_spending.customer_country,
      customer_spending.customer_lifetime_transactions,
      customer_spending.total_customer_revenue
    ]
    filters:
      customer_loyalty_tiers.is_top_10_in_spending_tier: "Yes"
    sorts: [customer_spending.spending_tier asc, customer_loyalty_tiers.spending_tier_rank asc]
    limit: 40
    show_view_names: false
    show_row_numbers: false
    size_to_fit: true
    table_theme: white
    defaults_version: 1
    listen:
      Current Loyalty Tier: customer_spending.loyaltytier
      Spending Tier: customer_spending.spending_tier
      Customer Country: customer_spending.customer_country
    row: 43
    col: 0
    width: 12
    height: 10

  - title: "Consolidated Directory: Top 10 Members for Each Current Loyalty Tier (Platinum, Gold, Silver, Bronze)"
    name: top_10_members_all_loyalty_tiers
    model: cymbal_gadgets
    explore: customer_spending
    type: looker_grid
    fields: [
      customer_spending.loyaltytier,
      customer_loyalty_tiers.loyalty_tier_rank,
      customer_spending.spending_rank,
      customer_spending.customerid,
      customer_spending.customer_name,
      customer_spending.spending_tier,
      customer_spending.customer_country,
      customer_spending.customer_lifetime_transactions,
      customer_spending.total_customer_revenue
    ]
    filters:
      customer_loyalty_tiers.is_top_10_in_loyalty_tier: "Yes"
    sorts: [customer_spending.loyaltytier asc, customer_loyalty_tiers.loyalty_tier_rank asc]
    limit: 40
    show_view_names: false
    show_row_numbers: false
    size_to_fit: true
    table_theme: white
    defaults_version: 1
    listen:
      Current Loyalty Tier: customer_spending.loyaltytier
      Spending Tier: customer_spending.spending_tier
      Customer Country: customer_spending.customer_country
    row: 43
    col: 12
    width: 12
    height: 10

  filters:
  - name: Spending Tier
    title: Spending Tier (Percentile Cohort)
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: cymbal_gadgets
    explore: customer_spending
    listens_to_filters: []
    field: customer_spending.spending_tier

  - name: Current Loyalty Tier
    title: Current Loyalty Tier
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: cymbal_gadgets
    explore: customer_spending
    listens_to_filters: []
    field: customer_spending.loyaltytier

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
    explore: customer_spending
    listens_to_filters: []
    field: customer_spending.customer_country

