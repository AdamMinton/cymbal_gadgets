- dashboard: unified_executive_overview
  title: Unified Executive Overview
  preferred_viewer: dashboards-next
  crossfilter_enabled: true
  layout: newspaper
  elements:
  - name: header_tile
    type: text
    title_text: "📈 Executive Overview Command Center"
    subtitle_text: "Performance metrics, monthly trends, and top quantum members"
    body_text: |
      <div style="border-left: 5px solid #4285F4; padding: 10px; background-color: #f8f9fa; font-family: 'Open Sans', 'Helvetica', sans-serif;">
        Welcome to the <b>Unified Executive Overview</b>. This dashboard summarizes top-level performance.
      </div>
    row: 0
    col: 0
    width: 24
    height: 3

  - title: Total Revenue
    name: Total Revenue
    model: cymbal_gadgets
    explore: transactions
    type: single_value
    fields: [transactions.total_revenue]
    listen:
      Transaction Date: transactions.transaction_date
      Category: transactions.category
    row: 3
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
      Category: transactions.category
    row: 3
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
      Category: transactions.category
    row: 3
    col: 12
    width: 6
    height: 4

  - title: Total Transactions
    name: Total Transactions
    model: cymbal_gadgets
    explore: transactions
    type: single_value
    fields: [transactions.count]
    listen:
      Transaction Date: transactions.transaction_date
      Category: transactions.category
    row: 3
    col: 18
    width: 6
    height: 4

  - title: Monthly Revenue Trend
    name: Monthly Revenue Trend
    model: cymbal_gadgets
    explore: transactions
    type: looker_line
    fields: [transactions.transaction_month, transactions.total_revenue]
    fill_fields: [transactions.transaction_month]
    sorts: [transactions.transaction_month desc]
    listen:
      Transaction Date: transactions.transaction_date
      Category: transactions.category
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    show_null_points: true
    interpolation: linear
    row: 7
    col: 0
    width: 14
    height: 8

  - title: Revenue by Category
    name: Revenue by Category
    model: cymbal_gadgets
    explore: transactions
    type: looker_pie
    fields: [transactions.category, transactions.total_revenue]
    sorts: [transactions.total_revenue desc]
    listen:
      Transaction Date: transactions.transaction_date
      Category: transactions.category
    limit: 500
    value_labels: labels
    label_type: labPer
    row: 7
    col: 14
    width: 10
    height: 8

  - title: Top Quantum Members
    name: Top Quantum Members
    model: cymbal_gadgets
    explore: transactions
    type: looker_grid
    fields: [transactions.customer_name, customer_spending_stats.lifetime_revenue]
    filters:
      customer_spending_stats.spending_tier: '1 - Quantum (Top 1%)'
    sorts: [customer_spending_stats.lifetime_revenue desc]
    listen:
      Transaction Date: transactions.transaction_date
      Category: transactions.category
    limit: 10
    row: 15
    col: 0
    width: 24
    height: 8

  filters:
  - name: Transaction Date
    title: Transaction Date
    type: field_filter
    default_value: 90 days
    allow_multiple_values: true
    required: false
    model: cymbal_gadgets
    explore: transactions
    field: transactions.transaction_date

  - name: Category
    title: Category
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: cymbal_gadgets
    explore: transactions
    field: transactions.category
