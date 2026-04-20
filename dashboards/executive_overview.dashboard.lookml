- dashboard: executive_transactions_overview
  title: Executive Transactions Overview
  preferred_viewer: dashboards-next
  crossfilter_enabled: true
  layout: newspaper
  elements:
  - name: header_tile
    type: text
    title_text: "📈 Executive Performance Overview"
    subtitle_text: "Comprehensive analysis of Revenue, Gross Profit, and Sales Trends"
    body_text: |
      <div style="border-left: 5px solid #4285F4; padding: 10px; background-color: #f8f9fa; font-family: 'Open Sans', 'Helvetica', sans-serif;">
        Welcome to the <b>Executive Transactions Overview</b>. This dashboard provides real-time visibility into our core retail metrics.
        <ul style="margin-top: 10px;">
          <li><b>KPIs</b>: Summary of top-line revenue and profitability.</li>
          <li><b>Trends</b>: Visual analysis of performance over time.</li>
          <li><b>Segmentation</b>: Deep dives into categories and brands.</li>
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
    limit: 500
    column_limit: 50
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
    limit: 500
    column_limit: 50
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
    limit: 500
    column_limit: 50
    row: 4
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
    row: 4
    col: 18
    width: 6
    height: 4

  - name: section_header_trends
    type: text
    title_text: "📊 Performance Trends & Composition"
    row: 8
    col: 0
    width: 24
    height: 2

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
    row: 10
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
    limit: 500
    column_limit: 50
    value_labels: labels
    label_type: labPer
    row: 10
    col: 14
    width: 10
    height: 8

  - name: section_header_brands
    type: text
    title_text: "🏆 Brand Leaderboard"
    row: 18
    col: 0
    width: 24
    height: 2

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
    row: 20
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
