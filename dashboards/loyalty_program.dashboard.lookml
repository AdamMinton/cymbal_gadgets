- dashboard: loyalty_program_analysis
  title: "💎 Loyalty Program: Spending Tier Analysis"
  description: "Executive analysis of customer spending tiers and loyalty segmentation."
  preferred_viewer: dashboards-next
  crossfilter_enabled: true
  layout: newspaper
  elements:

  - name: executive_summary
    type: text
    title_text: "📌 Executive Summary & Methodology"
    subtitle_text: "Threshold Analysis for Top Customers"
    body_text: |
      <div style="border-left: 5px solid #4285F4; padding: 15px; background-color: #f8f9fa; font-family: 'Open Sans', 'Helvetica', sans-serif;">
        This dashboard presents the results of our <b>Customer Spending Analysis</b>. We have identified four distinct tiers based on lifetime revenue:
        <ul style="margin-top: 10px;">
          <li><b>Quantum (Top 1%)</b>: High-value advocates spending over <b>$46,127</b>.</li>
          <li><b>Prism (Top 5%)</b>: Premium customers spending over <b>$29,774</b>.</li>
          <li><b>Pulse (Top 10%)</b>: Active growth segment spending over <b>$23,255</b>.</li>
          <li><b>Standard</b>: General customer base.</li>
        </ul>
        <i>Methodology: Percentile thresholds were calculated using Native Derived Tables (NDTs) on our complete transaction history.</i>
      </div>
    row: 0
    col: 0
    width: 24
    height: 4

  - title: Revenue by Tier
    name: Revenue by Tier
    model: cymbal_gadgets
    explore: transactions
    type: looker_pie
    fields: [customer_spending_stats.spending_tier, transactions.total_revenue]
    sorts: [customer_spending_stats.spending_tier asc]
    limit: 500
    value_labels: labels
    label_type: labPer
    row: 4
    col: 0
    width: 12
    height: 8

  - title: Customer Count by Tier
    name: Customer Count by Tier
    model: cymbal_gadgets
    explore: transactions
    type: looker_column
    fields: [customer_spending_stats.spending_tier, customer_spending_stats.count_customers]
    sorts: [customer_spending_stats.spending_tier asc]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    row: 4
    col: 12
    width: 12
    height: 8

  - name: top_members_header
    type: text
    title_text: "🏆 Top 10 Members by Tier"
    row: 12
    col: 0
    width: 24
    height: 2

  - title: "Quantum Members (Top 1%)"
    name: quantum_members
    model: cymbal_gadgets
    explore: transactions
    type: looker_grid
    fields: [transactions.customer_name, customer_spending_stats.lifetime_revenue]
    filters:
      customer_spending_stats.spending_tier: "1 - Quantum (Top 1%)"
    sorts: [customer_spending_stats.lifetime_revenue desc]
    limit: 10
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    table_theme: white
    header_font_size: 12
    rows_font_size: 12
    row: 14
    col: 0
    width: 8
    height: 8

  - title: "Prism Members (Top 5%)"
    name: prism_members
    model: cymbal_gadgets
    explore: transactions
    type: looker_grid
    fields: [transactions.customer_name, customer_spending_stats.lifetime_revenue]
    filters:
      customer_spending_stats.spending_tier: "2 - Prism (Top 5%)"
    sorts: [customer_spending_stats.lifetime_revenue desc]
    limit: 10
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    table_theme: white
    header_font_size: 12
    rows_font_size: 12
    row: 14
    col: 8
    width: 8
    height: 8

  - title: "Pulse Members (Top 10%)"
    name: pulse_members
    model: cymbal_gadgets
    explore: transactions
    type: looker_grid
    fields: [transactions.customer_name, customer_spending_stats.lifetime_revenue]
    filters:
      customer_spending_stats.spending_tier: "3 - Pulse (Top 10%)"
    sorts: [customer_spending_stats.lifetime_revenue desc]
    limit: 10
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    table_theme: white
    header_font_size: 12
    rows_font_size: 12
    row: 14
    col: 16
    width: 8
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
