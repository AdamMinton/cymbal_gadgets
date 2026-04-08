---
- dashboard: customer_pulse
  title: Customer Pulse
  preferred_viewer: dashboards-next
  crossfilter_enabled: true
  description: ''
  filters_bar_collapsed: true
  filters_location_top: false
  preferred_slug: 2JshIUCKDgqmpVYk1LaMOP
  theme_name: cymbal_gadgets
  layout: newspaper
  tabs:
  - name: Overview
    label: Overview
  - name: Reviews
    label: Reviews
  elements:
  - title: Total Revenue
    name: Total Revenue
    model: cymbal_gadgets
    explore: transactions
    type: single_value
    fields: [transactions.total_revenue]
    limit: 5000
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    smart_single_value_size: true
    defaults_version: 1
    listen:
      Brand: transactions.brand
      Category: transactions.category
      Product Name: transactions.productname
      Transaction Date: transactions.transaction_date
    row: 0
    col: 0
    width: 3
    height: 3
    tab_name: Overview
  - title: Total Gross Profit
    name: Total Gross Profit
    model: cymbal_gadgets
    explore: transactions
    type: single_value
    fields: [transactions.total_gross_profit]
    limit: 5000
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    smart_single_value_size: true
    defaults_version: 1
    listen:
      Brand: transactions.brand
      Category: transactions.category
      Product Name: transactions.productname
      Transaction Date: transactions.transaction_date
    row: 0
    col: 6
    width: 3
    height: 3
    tab_name: Overview
  - title: Average Order Value
    name: Average Order Value
    model: cymbal_gadgets
    explore: transactions
    type: single_value
    fields: [transactions.average_order_value]
    limit: 5000
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    smart_single_value_size: true
    defaults_version: 1
    listen:
      Brand: transactions.brand
      Category: transactions.category
      Product Name: transactions.productname
      Transaction Date: transactions.transaction_date
    row: 0
    col: 9
    width: 3
    height: 3
    tab_name: Overview
  - title: Unique Customers
    name: Unique Customers
    model: cymbal_gadgets
    explore: transactions
    type: single_value
    fields: [transactions.unique_customers]
    limit: 5000
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    smart_single_value_size: true
    defaults_version: 1
    listen:
      Brand: transactions.brand
      Category: transactions.category
      Product Name: transactions.productname
      Transaction Date: transactions.transaction_date
    row: 0
    col: 3
    width: 3
    height: 3
    tab_name: Overview
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
    tab_name: Overview
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
    tab_name: Overview
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
    tab_name: Overview
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
    tab_name: Overview
  - title: Monthly Review Volume
    name: Monthly Review Volume
    model: cymbal_gadgets
    explore: transactions
    type: looker_line
    fields: [product_reviews.count, product_reviews.reviewdate_month]
    fill_fields: [product_reviews.reviewdate_month]
    sorts: [product_reviews.reviewdate_month desc]
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
    interpolation: monotone
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      product_reviews.count: area
    discontinuous_nulls: false
    custom_color_enabled: true
    show_single_value_title: true
    smart_single_value_size: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    hidden_pivots: {}
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    listen:
      Brand: transactions.brand
      Category: transactions.category
      Product Name: transactions.productname
      Rating (1-5): product_reviews.rating
    row: 3
    col: 0
    width: 12
    height: 7
    tab_name: Reviews
  - title: Total Positive Reviews
    name: Total Positive Reviews
    model: cymbal_gadgets
    explore: transactions
    type: single_value
    fields: [product_reviews.count_positive_reviews]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    smart_single_value_size: true
    defaults_version: 1
    listen:
      Brand: transactions.brand
      Category: transactions.category
      Product Name: transactions.productname
      Rating (1-5): product_reviews.rating
    row: 0
    col: 8
    width: 8
    height: 3
    tab_name: Reviews
  - title: Total Reviews
    name: Total Reviews
    model: cymbal_gadgets
    explore: transactions
    type: single_value
    fields: [product_reviews.count]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    smart_single_value_size: true
    defaults_version: 1
    listen:
      Brand: transactions.brand
      Category: transactions.category
      Product Name: transactions.productname
      Rating (1-5): product_reviews.rating
    row: 0
    col: 16
    width: 8
    height: 3
    tab_name: Reviews
  - title: Average Product Rating
    name: Average Product Rating (2)
    model: cymbal_gadgets
    explore: transactions
    type: single_value
    fields: [product_reviews.average_rating]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: ''
    smart_single_value_size: true
    conditional_formatting: [{type: greater than, value: 4, fields: !!null '', apply_formatting_to_row: false,
        cell_format: {background_color: "#2e7d32", font_color: !!null '', color_application: {
            collection_id: cymbal_gadgets, palette_id: cymbal_gadgets-sequential-0,
            options: {mirror: false, reverse: false, stepped: false}}, font_style: {
            bold: false, italic: false, strikethrough: false}}, row_format: {background_color: "#a461ee",
          font_color: !!null '', color_application: {collection_id: cymbal_gadgets,
            options: {mirror: false, reverse: false, stepped: false}}, font_style: {
            bold: false, italic: false, strikethrough: false}}, apply_to: allNumericFields},
      {type: not null, value: 4, fields: !!null '', apply_formatting_to_row: false,
        cell_format: {background_color: "#c62828", font_color: !!null '', color_application: {
            collection_id: cymbal_gadgets, palette_id: cymbal_gadgets-sequential-0,
            options: {mirror: false, reverse: false, stepped: false}}, font_style: {
            bold: false, italic: false, strikethrough: false}}, row_format: {background_color: "#a461ee",
          font_color: !!null '', color_application: {collection_id: cymbal_gadgets,
            options: {mirror: false, reverse: false, stepped: false}}, font_style: {
            bold: false, italic: false, strikethrough: false}}, apply_to: allNumericFields}]
    defaults_version: 1
    listen:
      Brand: transactions.brand
      Category: transactions.category
      Product Name: transactions.productname
      Rating (1-5): product_reviews.rating
    row: 0
    col: 0
    width: 8
    height: 3
    tab_name: Reviews
  - title: Rating Distribution
    name: Rating Distribution
    model: cymbal_gadgets
    explore: transactions
    type: looker_column
    fields: [product_reviews.count, product_reviews.rating_tier]
    fill_fields: [product_reviews.rating_tier]
    filters:
      product_reviews.rating: NOT NULL
    sorts: [product_reviews.rating_tier]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: dimension
      description: ''
      label: Rating
      value_format:
      value_format_name:
      calculation_type: bin
      dimension: rating
      args:
      - product_reviews.rating
      - '1'
      - '1'
      - '5'
      -
      - classic
      _kind_hint: dimension
      _type_hint: string
    - category: dimension
      description: ''
      label: Rating Dist
      value_format:
      value_format_name:
      calculation_type: group_by
      dimension: rating_dist
      args:
      - product_reviews.rating
      - - label: '1'
          filter: "<2"
        - label: '2'
          filter: "<3"
        - label: '3'
          filter: "<4"
        - label: '4'
          filter: "<5"
        - label: '5'
          filter: '5'
      - No Score
      _kind_hint: dimension
      _type_hint: string
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
    x_axis_zoom: true
    y_axis_zoom: true
    show_null_points: true
    interpolation: monotone
    discontinuous_nulls: false
    custom_color_enabled: true
    show_single_value_title: true
    smart_single_value_size: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Brand: transactions.brand
      Category: transactions.category
      Product Name: transactions.productname
      Rating (1-5): product_reviews.rating
    row: 3
    col: 12
    width: 12
    height: 7
    tab_name: Reviews
  - title: Category Leaderboard
    name: Category Leaderboard
    model: cymbal_gadgets
    explore: transactions
    type: looker_grid
    fields: [product_reviews.average_rating, product_reviews.count, transactions.category]
    sorts: [product_reviews.average_rating desc 0]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: transparent
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_cell_visualizations:
      product_reviews.average_rating:
        is_active: false
    table_show_footer: false
    table_enable_pagination: false
    table_page_size_options: 20, 50, 100
    table_column_hover_highlight_enable: false
    table_show_headers: true
    header_font_bold: false
    header_font_italic: false
    cell_font_size: '12'
    cell_font_weight: ''
    cell_font_style: ''
    cell_text_alignment: ''
    table_custom_border_enable: false
    table_custom_border_width:
    table_custom_border_color: "#dde2eb"
    table_custom_border_style: solid
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    smart_single_value_size: true
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Brand: transactions.brand
      Category: transactions.category
      Product Name: transactions.productname
      Rating (1-5): product_reviews.rating
    row: 10
    col: 0
    width: 9
    height: 7
    tab_name: Reviews
  - title: Recent Reviews
    name: Recent Reviews
    model: cymbal_gadgets
    explore: transactions
    type: looker_grid
    fields: [product_reviews.reviewdate_date, transactions.category, product_reviews.productname,
      product_reviews.reviewtext, product_reviews.rating]
    sorts: [product_reviews.reviewdate_date desc]
    limit: 10
    column_limit: 50
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: false
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: transparent
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_column_widths:
      product_reviews.reviewdate_date: 98
      transactions.category: 88
      product_reviews.rating: 172
      product_reviews.productname: 124
    series_cell_visualizations:
      product_reviews.average_rating:
        is_active: false
    table_show_footer: false
    table_enable_pagination: false
    table_page_size_options: 20, 50, 100
    table_column_hover_highlight_enable: false
    table_show_headers: true
    header_font_bold: false
    header_font_italic: false
    cell_font_size: '12'
    cell_font_weight: ''
    cell_font_style: ''
    cell_text_alignment: ''
    table_custom_border_enable: false
    table_custom_border_width:
    table_custom_border_color: "#dde2eb"
    table_custom_border_style: solid
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    smart_single_value_size: true
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Brand: transactions.brand
      Category: transactions.category
      Product Name: transactions.productname
      Rating (1-5): product_reviews.rating
    row: 10
    col: 9
    width: 15
    height: 7
    tab_name: Reviews
  filters:
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
  - name: Rating (1-5)
    title: Rating (1-5)
    type: field_filter
    default_value: "[0,5]"
    allow_multiple_values: true
    required: false
    ui_config:
      type: range_slider
      display: inline
      options:
        min: 0
        max: 5
    model: cymbal_gadgets
    explore: transactions
    listens_to_filters: []
    field: product_reviews.rating
