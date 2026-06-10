view: transactions {
  sql_table_name: `looker-private-demo.cymbal_gadgets.transactions` ;;

  # --- Hidden IDs ---
  dimension: salesid {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.salesid ;;
  }
  dimension: customerid {
    hidden: yes
    type: number
    sql: ${TABLE}.customerid ;;
  }
  dimension: orderid {
    hidden: yes
    type: string
    sql: ${TABLE}.orderid ;;
  }
  dimension: productid {
    hidden: yes
    type: number
    sql: ${TABLE}.productid ;;
  }
  dimension: storeid {
    hidden: yes
    type: number
    sql: ${TABLE}.storeid ;;
  }

  # --- Date & Time ---
  dimension_group: transaction {
    label: "Transaction"
    type: time
    timeframes: [raw, date, week, week_of_year, month, month_name, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.transaction_date ;;
  }
  dimension: isweekend {
    group_label: "Transaction Dates"
    label: "Is Weekend?"
    type: yesno
    sql: ${TABLE}.isweekend ;;
  }

  # --- Customer Info (Grouped) ---
  dimension: firstname {
    hidden: yes
    type: string
    sql: ${TABLE}.firstname ;;
  }
  dimension: lastname {
    hidden: yes
    type: string
    sql: ${TABLE}.lastname ;;
  }

  # Dimension: Full Name
  dimension: customer_name {
    group_label: "Customer Info"
    label: "Customer Name"
    description: "Full name of the customer."
    type: string
    sql: CONCAT(${firstname}, ' ', ${lastname}) ;;
  }
  dimension: customer_city {
    group_label: "Customer Info"
    label: "Customer City"
    type: string
    sql: ${TABLE}.customer_city ;;
  }
  dimension: customer_country {
    group_label: "Customer Info"
    label: "Customer Country"
    type: string
    sql: ${TABLE}.customer_country ;;
    map_layer_name: countries
  }
  dimension: loyaltytier {
    group_label: "Customer Info"
    label: "Loyalty Tier"
    type: string
    sql: ${TABLE}.loyaltytier ;;
  }
  dimension_group: customer_registrationdate {
    group_label: "Customer Info"
    label: "Customer Registration"
    type: time
    timeframes: [date, month, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.customer_registrationdate ;;
  }

  # --- Store Info (Grouped) ---
  dimension: storename {
    group_label: "Store Info"
    label: "Store Name"
    type: string
    sql: ${TABLE}.storename ;;
  }
  dimension: store_city {
    group_label: "Store Info"
    label: "Store City"
    type: string
    sql: ${TABLE}.store_city ;;
  }
  dimension: store_country {
    group_label: "Store Info"
    label: "Store Country"
    type: string
    sql: ${TABLE}.store_country ;;
  }
  dimension: store_region {
    group_label: "Store Info"
    label: "Store Region"
    type: string
    sql: ${TABLE}.store_region ;;
  }
  dimension: latitude {
    hidden: yes
    type: number
    sql: ${TABLE}.latitude ;;
  }
  dimension: longitude {
    hidden: yes
    type: number
    sql: ${TABLE}.longitude ;;
  }

  # Dimension: Location Mapping
  dimension: store_location {
    group_label: "Store Info"
    label: "Store Map Location"
    type: location
    sql_latitude: ${latitude} ;;
    sql_longitude: ${longitude} ;;
  }

  # --- Product & Order Info (Grouped) ---
  dimension: brand {
    group_label: "Product Info"
    label: "Brand"
    type: string
    sql: ${TABLE}.brand ;;
  }
  dimension: category {
    group_label: "Product Info"
    label: "Category"
    type: string
    sql: ${TABLE}.category ;;
  }
  dimension: productname {
    group_label: "Product Info"
    label: "Product Name"
    type: string
    sql: ${TABLE}.productname ;;
  }
  dimension: saleschannelname {
    group_label: "Order Info"
    label: "Sales Channel"
    type: string
    sql: ${TABLE}.saleschannelname ;;
  }
  dimension: paymenttypename {
    group_label: "Order Info"
    label: "Payment Type"
    type: string
    sql: ${TABLE}.paymenttypename ;;
  }

  # --- Financial Dimensions (Hidden from UI, used for Measures) ---
  dimension: product_cost {
    hidden: yes
    type: number
    sql: ${TABLE}.product_cost ;;
  }
  dimension: product_master_price {
    hidden: yes
    type: number
    sql: ${TABLE}.product_master_price ;;
  }
  dimension: quantity {
    hidden: yes
    type: number
    sql: ${TABLE}.quantity ;;
  }
  dimension: totalprice {
    hidden: yes
    type: number
    sql: ${TABLE}.totalprice ;;
  }
  dimension: discountamount {
    hidden: yes
    type: number
    sql: ${TABLE}.discountamount ;;
  }
  dimension: shippingcost {
    hidden: yes
    type: number
    sql: ${TABLE}.shippingcost ;;
  }
  dimension: taxamount {
    hidden: yes
    type: number
    sql: ${TABLE}.taxamount ;;
  }

  # --- Financial Dimensions ---

  dimension: gross_revenue {
    group_label: "Financials"
    label: "Gross Revenue"
    description: "Gross Revenue before discounts (Product Master Price * Quantity)"
    type: number
    sql: ${product_master_price} * ${quantity} ;;
    value_format_name: usd
  }

  dimension: net_revenue {
    group_label: "Financials"
    label: "Net Revenue"
    description: "Net Revenue after discounts (Gross Revenue - Discount Amount)"
    type: number
    sql: ${gross_revenue} - ${discountamount} ;;
    value_format_name: usd
  }

  dimension: cogs {
    group_label: "Financials"
    label: "COGS"
    description: "Cost of Goods Sold (Product Cost * Quantity)"
    type: number
    sql: ${product_cost} * ${quantity} ;;
    value_format_name: usd
  }

  dimension: gross_profit {
    group_label: "Financials"
    label: "Gross Profit"
    description: "Net Profit before operating expenses (Net Revenue - COGS)"
    type: number
    sql: ${net_revenue} - ${cogs} ;;
    value_format_name: usd
  }

  dimension: lost_revenue {
    group_label: "Financials"
    label: "Lost Revenue"
    description: "Revenue from Online transactions that occurred more than 30 days ago but have a null shipment status."
    type: number
    # Restricting to Online transactions because In-Store transactions never have shipment status
    sql: CASE WHEN ${saleschannelname} = 'Online' AND DATE_DIFF(CURRENT_DATE(), ${transaction_date}, DAY) > 30 AND ${shipment_status} IS NULL THEN ${net_revenue} ELSE 0 END ;;
    value_format_name: usd
  }

  # --- Measures ---
  measure: count {
    label: "Count"
    type: count
    drill_fields: [transaction_details*]
  }

  measure: total_revenue {
    label: "Total Revenue"
    description: "Sum of total price for all transactions. Note: Includes tax and shipping."
    type: sum
    sql: ${totalprice} ;;
    value_format_name: usd_0
    drill_fields: [transaction_details*]
  }

  measure: total_gross_revenue {
    group_label: "Financial Measures"
    label: "Total Gross Revenue"
    description: "Total Gross Revenue before discounts"
    type: sum
    sql: ${gross_revenue} ;;
    value_format_name: usd_0
    drill_fields: [transaction_details*]
  }

  measure: total_net_revenue {
    group_label: "Financial Measures"
    label: "Total Net Revenue"
    description: "Total Net Revenue after discounts"
    type: sum
    sql: ${net_revenue} ;;
    value_format_name: usd_0
    drill_fields: [transaction_details*]
  }

  measure: total_cogs {
    group_label: "Financial Measures"
    label: "Total COGS"
    description: "Total Cost of Goods Sold"
    type: sum
    sql: ${cogs} ;;
    value_format_name: usd_0
    drill_fields: [transaction_details*]
  }

  measure: total_gross_profit {
    group_label: "Financial Measures"
    label: "Total Gross Profit"
    description: "Sum of gross profit across all transactions."
    type: sum
    sql: ${gross_profit} ;;
    value_format_name: usd_0
    drill_fields: [transaction_details*]
  }

  measure: total_quantity_sold {
    label: "Total Quantity Sold"
    type: sum
    sql: ${quantity} ;;
  }

  measure: average_order_value {
    label: "Average Order Value (AOV)"
    description: "Average revenue generated per transaction."
    type: average
    sql: ${totalprice} ;;
    value_format_name: usd
  }

  measure: gross_margin_percentage {
    group_label: "Financial Measures"
    label: "Gross Margin %"
    description: "Total Gross Profit divided by Total Net Revenue."
    type: number
    sql: 1.0 * ${total_gross_profit} / NULLIF(${total_net_revenue}, 0) ;;
    value_format_name: percent_1
  }

  measure: total_lost_revenue {
    group_label: "Financial Measures"
    label: "Total Lost Revenue"
    description: "Total Lost Revenue from Online transactions that occurred more than 30 days ago but have a null shipment status."
    type: sum
    sql: ${lost_revenue} ;;
    value_format_name: usd_0
    drill_fields: [transaction_details*]
  }

  measure: unique_customers {
    label: "Total Unique Customers"
    type: count_distinct
    sql: ${customerid} ;;
  }

  dimension: shipment_status {
    label: "Shipment status"
    sql: ${TABLE}.shipment_status;;
  }
  dimension: shippingmethod {
    label: "Shipping method"
    sql: ${TABLE}.shipmentmethod;;
  }

  dimension: distribution_center_city {
    label: "Distribution Center"
    sql: ${TABLE}.distribution_center_city ;;
  }

  # Count of transactions that are currently delayed
  measure: delayed_order_count {
    label: "Delayed Order Count"
    description: "Total number of orders with a delayed shipment status."
    type: count
    filters: [shipment_status: "Delayed"]
  }

  # ----- Sets of fields for drilling ------
  set: transaction_details {
    fields: [
      transaction_date,
      customer_name,
      storename,
      productname,
      category,
      saleschannelname,
      quantity,
      total_revenue
    ]
  }
}
