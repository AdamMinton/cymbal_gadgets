- dashboard: executive_spending_and_sales
  title: "💎 Executive Spending Tiers & Sales Overview"
  description: "High-level comparison of customer spending cohorts and loyalty tiers"
  preferred_viewer: dashboards-next
  crossfilter_enabled: true
  layout: newspaper
  elements:

  - name: banner_header
    type: text
    title_text: "🎯 Executive Customer Segmentation & Performance Dashboard"
    subtitle_text: "Direct side-by-side comparison of Lifetime Spending Cohorts vs Loyalty Tiers"
    body_text: |
      <div style="border-left: 5px solid #1E3A8A; padding: 15px; background-color: #f8fafc; font-family: 'Open Sans', 'Helvetica', sans-serif;">
        This executive command center contrasts our <b>Lifetime Customer Spending Tiers</b> (derived from total customer spend percentiles) against active <b>Loyalty Program Tiers</b>.
        <ul style="margin-top: 8px; margin-bottom: 0;">
          <li><b>Spending Tiers</b>: High-value cohorts calculated using percentile thresholds (Quantum = Top 1%, Prism = Top 5%, Pulse = Top 10%).</li>
          <li><b>Loyalty Tiers</b>: Active customer loyalty memberships.</li>
        </ul>
      </div>
    row: 0
    col: 0
    width: 24
    height: 4

  - title: Total Revenue
    name: Total Revenue
    model: cymbal_gadgets
    explore: transactions
    type: single_value
    fields: [transactions.total_revenue]
    listen:
      Transaction Date: transactions.transaction_date
    row: 4
    col: 0
    width: 6
    height: 4

  - title: Total Gross Profit
    name: Total Gross Profit
    model: cymbal_gadgets
    explore: transactions
    type: single_value
    fields: [transactions.total_gross_profit]
    listen:
      Transaction Date: transactions.transaction_date
    row: 4
    col: 6
    width: 6
    height: 4

  - title: Gross Margin %
    name: Gross Margin %
    model: cymbal_gadgets
    explore: transactions
    type: single_value
    fields: [transactions.gross_margin_percentage]
    listen:
      Transaction Date: transactions.transaction_date
    row: 4
    col: 12
    width: 6
    height: 4

  - title: Unique Customers
    name: Unique Customers
    model: cymbal_gadgets
    explore: transactions
    type: single_value
    fields: [transactions.unique_customers]
    listen:
      Transaction Date: transactions.transaction_date
    row: 4
    col: 18
    width: 6
    height: 4

  - name: comparison_section_header
    type: text
    title_text: "📊 Cohort Comparisons (Customer Spending Tiers vs Loyalty Tiers)"
    row: 8
    col: 0
    width: 24
    height: 2

  - title: Customer Count by Spending Tier
    name: Customer Count by Spending Tier
    model: cymbal_gadgets
    explore: transactions
    type: looker_column
    fields: [customer_spending_stats.spending_tier, customer_spending_stats.count_customers]
    sorts: [customer_spending_stats.spending_tier asc]
    limit: 500
    listen:
      Transaction Date: transactions.transaction_date
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    colors: ["#1E3A8A"]
    row: 10
    col: 0
    width: 12
    height: 8

  - title: Customer Count by Loyalty Tier
    name: Customer Count by Loyalty Tier
    model: cymbal_gadgets
    explore: transactions
    type: looker_column
    fields: [transactions.loyaltytier, transactions.unique_customers]
    sorts: [transactions.unique_customers desc]
    limit: 500
    listen:
      Transaction Date: transactions.transaction_date
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    colors: ["#10B981"]
    row: 10
    col: 12
    width: 12
    height: 8

  - title: Revenue Share by Spending Tier
    name: Revenue Share by Spending Tier
    model: cymbal_gadgets
    explore: transactions
    type: looker_pie
    fields: [customer_spending_stats.spending_tier, transactions.total_revenue]
    sorts: [customer_spending_stats.spending_tier asc]
    limit: 500
    listen:
      Transaction Date: transactions.transaction_date
    value_labels: labels
    label_type: labPer
    row: 18
    col: 0
    width: 12
    height: 8

  - title: Revenue Share by Loyalty Tier
    name: Revenue Share by Loyalty Tier
    model: cymbal_gadgets
    explore: transactions
    type: looker_pie
    fields: [transactions.loyaltytier, transactions.total_revenue]
    sorts: [transactions.total_revenue desc]
    limit: 500
    listen:
      Transaction Date: transactions.transaction_date
    value_labels: labels
    label_type: labPer
    row: 18
    col: 12
    width: 12
    height: 8

  - name: crosstab_section_header
    type: text
    title_text: "🔍 Cross-Segmentation & Intersection Matrix"
    row: 26
    col: 0
    width: 24
    height: 2

  - title: Multi-Tier Segmentation Matrix
    name: Multi-Tier Segmentation Matrix
    model: cymbal_gadgets
    explore: transactions
    type: looker_grid
    fields: [customer_spending_stats.spending_tier, transactions.loyaltytier, customer_spending_stats.count_customers, transactions.total_revenue, transactions.gross_margin_percentage]
    pivots: [transactions.loyaltytier]
    sorts: [customer_spending_stats.spending_tier asc, transactions.total_revenue desc]
    limit: 500
    listen:
      Transaction Date: transactions.transaction_date
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    table_theme: white
    header_font_size: 12
    rows_font_size: 12
    row: 28
    col: 0
    width: 24
    height: 8

  filters:
  - name: Transaction Date
    title: Transaction Date
    type: field_filter
    default_value: 365 days
    allow_multiple_values: true
    required: false
    model: cymbal_gadgets
    explore: transactions
    field: transactions.transaction_date
