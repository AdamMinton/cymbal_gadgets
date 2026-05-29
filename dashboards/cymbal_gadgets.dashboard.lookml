---
- dashboard: cymbal_gadgets
  title: Cymbal Gadgets
  preferred_viewer: dashboards-next
  crossfilter_enabled: true
  description: ''
  filters_bar_collapsed: true
  filters_location_top: false
  preferred_slug: KNuEZswuiZQoTzqzHZKsJT
  layout: newspaper
  tabs:
  - name: ''
    label: ''
  elements:
  - title: Total Revenue
    name: Total Revenue
    model: cymbal_gadgets
    explore: transactions
    type: single_value
    fields: [transactions.total_revenue]
    limit: 5000
    column_limit: 50
    listen:
      Brand: transactions.brand
      Category: transactions.category
      Product Name: transactions.productname
      Transaction Date: transactions.transaction_date
    row: 0
    col: 0
    width: 3
    height: 3
    tab_name: ''
  - title: Total Gross Profit
    name: Total Gross Profit
    model: cymbal_gadgets
    explore: transactions
    type: single_value
    fields: [transactions.total_gross_profit]
    limit: 5000
    column_limit: 50
    listen:
      Brand: transactions.brand
      Category: transactions.category
      Product Name: transactions.productname
      Transaction Date: transactions.transaction_date
    row: 0
    col: 6
    width: 3
    height: 3
    tab_name: ''
  - title: Average Order Value
    name: Average Order Value
    model: cymbal_gadgets
    explore: transactions
    type: single_value
    fields: [transactions.average_order_value]
    limit: 5000
    column_limit: 50
    listen:
      Brand: transactions.brand
      Category: transactions.category
      Product Name: transactions.productname
      Transaction Date: transactions.transaction_date
    row: 0
    col: 9
    width: 3
    height: 3
    tab_name: ''
  - title: Unique Customers
    name: Unique Customers
    model: cymbal_gadgets
    explore: transactions
    type: single_value
    fields: [transactions.unique_customers]
    limit: 5000
    column_limit: 50
    listen:
      Brand: transactions.brand
      Category: transactions.category
      Product Name: transactions.productname
      Transaction Date: transactions.transaction_date
    row: 0
    col: 3
    width: 3
    height: 3
    tab_name: ''
  - title: Revenue Trend over Time
    name: Revenue Trend over Time
    model: cymbal_gadgets
    explore: transactions
    type: looker_area
    fields: [transactions.transaction_week_of_year, transactions.total_revenue, transactions.transaction_year]
    pivots: [transactions.transaction_year]
    fill_fields: [transactions.transaction_year, transactions.transaction_week_of_year]
    sorts: [transactions.transaction_year, transactions.transaction_week_of_year]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Brand: transactions.brand
      Category: transactions.category
      Product Name: transactions.productname
      Transaction Date: transactions.transaction_date
    row: 3
    col: 0
    width: 12
    height: 9
    tab_name: ''
  - title: Average Product Rating
    name: Average Product Rating
    model: cymbal_gadgets
    explore: transactions
    type: looker_bar
    fields: [product_reviews.average_rating, transactions.category]
    sorts: [product_reviews.average_rating desc]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_pivots: {}
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    listen:
      Brand: transactions.brand
      Category: transactions.category
      Product Name: transactions.productname
      Transaction Date: transactions.transaction_date
    row: 0
    col: 12
    width: 12
    height: 6
    tab_name: ''
  - title: Top Categories by Revenue
    name: Top Categories by Revenue
    model: cymbal_gadgets
    explore: transactions
    type: looker_column
    fields: [transactions.category, transactions.total_revenue]
    sorts: [transactions.total_revenue desc]
    limit: 10
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    listen:
      Brand: transactions.brand
      Category: transactions.category
      Product Name: transactions.productname
      Transaction Date: transactions.transaction_date
    row: 6
    col: 12
    width: 12
    height: 6
    tab_name: ''
  - title: Campaign Impact by Campaign Name
    name: Campaign Impact by Campaign Name
    model: cymbal_gadgets
    explore: transactions
    type: looker_bar
    fields: [marketing_campaign_impact.campaignname, marketing_campaign_impact.total_campaign_impact,
      marketing_campaign_impact.count]
    sorts: [marketing_campaign_impact.total_campaign_impact desc]
    limit: 10
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: !!null '', orientation: top, series: [{axisId: marketing_campaign_impact.total_campaign_impact,
            id: marketing_campaign_impact.total_campaign_impact, name: Total Campaign
              Impact}], showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}, {label: '', orientation: bottom, series: [
          {axisId: marketing_campaign_impact.count, id: marketing_campaign_impact.count,
            name: Total Campaign Events}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Brand: transactions.brand
      Category: transactions.category
      Product Name: transactions.productname
      Transaction Date: transactions.transaction_date
    row: 12
    col: 0
    width: 24
    height: 11
    tab_name: ''
  filters:
  - name: Brand
    title: Brand
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: cymbal_gadgets
    explore: transactions
    listens_to_filters: []
    field: transactions.brand
  - name: Category
    title: Category
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: cymbal_gadgets
    explore: transactions
    listens_to_filters: []
    field: transactions.category
  - name: Product Name
    title: Product Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: cymbal_gadgets
    explore: transactions
    listens_to_filters: []
    field: transactions.productname
  - name: Transaction Date
    title: Transaction Date
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: cymbal_gadgets
    explore: transactions
    listens_to_filters: []
    field: transactions.transaction_date
