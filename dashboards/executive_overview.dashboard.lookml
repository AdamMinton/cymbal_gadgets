- dashboard: executive_transactions_overview
  title: Executive Transactions Overview
  preferred_viewer: dashboards-next
  crossfilter_enabled: true
  layout: newspaper
  elements:
  - title: Total Revenue
    name: Total Revenue
    model: cymbal_gadgets
    explore: transactions
    type: single_value
    fields: [transactions.total_revenue]
    limit: 500
    column_limit: 50
    row: 0
    col: 0
    width: 6
    height: 4

  - title: Total Gross Profit
    name: Total Gross Profit
    model: cymbal_gadgets
    explore: transactions
    type: single_value
    fields: [transactions.total_gross_profit]
    limit: 500
    column_limit: 50
    row: 0
    col: 6
    width: 6
    height: 4

  - title: Gross Margin %
    name: Gross Margin %
    model: cymbal_gadgets
    explore: transactions
    type: single_value
    fields: [transactions.gross_margin_percentage]
    limit: 500
    column_limit: 50
    row: 0
    col: 12
    width: 6
    height: 4

  - title: Total Transactions
    name: Total Transactions
    model: cymbal_gadgets
    explore: transactions
    type: single_value
    fields: [transactions.count]
    limit: 500
    column_limit: 50
    row: 0
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
    limit: 500
    column_limit: 50
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
    row: 4
    col: 0
    width: 12
    height: 8

  - title: Revenue by Category
    name: Revenue by Category
    model: cymbal_gadgets
    explore: transactions
    type: looker_pie
    fields: [transactions.category, transactions.total_revenue]
    sorts: [transactions.total_revenue desc]
    limit: 500
    column_limit: 50
    value_labels: labels
    label_type: labPer
    row: 4
    col: 12
    width: 12
    height: 8

  - title: Top Brands by Revenue
    name: Top Brands by Revenue
    model: cymbal_gadgets
    explore: transactions
    type: looker_column
    fields: [transactions.brand, transactions.total_revenue]
    sorts: [transactions.total_revenue desc]
    limit: 10
    column_limit: 50
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
    row: 12
    col: 0
    width: 24
    height: 8

  filters:
  - name: Transaction Date
    title: Transaction Date
    type: field_filter
    default_value: 30 days
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
