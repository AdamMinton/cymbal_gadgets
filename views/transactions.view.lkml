view: transactions {
  sql_table_name: `looker-private-demo.cymbal_gadgets.transactions` ;;

  # --- Hidden IDs ---
  dimension: pk1_sales_id {
    primary_key: yes
    hidden: yes
    type: number
    group_label: "IDs"
    description: "Primary key: Unique identifier for each transaction."
    sql: ${TABLE}.salesid ;;
  }
  dimension: customerid {
    hidden: yes
    type: number
    group_label: "IDs"
    description: "Identifier for the customer who made the transaction."
    sql: ${TABLE}.customerid ;;
  }
  dimension: orderid {
    hidden: yes
    type: string
    group_label: "IDs"
    description: "Identifier for the order containing this transaction."
    sql: ${TABLE}.orderid ;;
  }
  dimension: productid {
    hidden: yes
    type: number
    group_label: "IDs"
    description: "Identifier for the product purchased in this transaction."
    sql: ${TABLE}.productid ;;
  }
  dimension: storeid {
    hidden: yes
    type: number
    group_label: "IDs"
    description: "Identifier for the store where the transaction occurred."
    sql: ${TABLE}.storeid ;;
  }

  # --- Date & Time ---
  dimension_group: transaction {
    label: "Transaction"
    description: "The date and time the transaction took place."
    type: time
    timeframes: [raw, date, week, week_of_year, month, month_name, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.transaction_date ;;
  }
  dimension: isweekend {
    group_label: "Transaction Dates"
    label: "Is Weekend?"
    description: "Indicates if the transaction occurred on a Saturday or Sunday."
    type: yesno
    sql: ${TABLE}.isweekend ;;
  }

  # --- Customer Info (Grouped) ---
  dimension: firstname {
    hidden: yes
    description: "The customer's first name."
    type: string
    sql: ${TABLE}.firstname ;;
  }
  dimension: lastname {
    hidden: yes
    description: "The customer's last name."
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
    description: "The city where the customer is located."
    type: string
    sql: ${TABLE}.customer_city ;;
  }
  dimension: customer_country {
    group_label: "Customer Info"
    label: "Customer Country"
    description: "The country where the customer is located."
    type: string
    sql: ${TABLE}.customer_country ;;
    map_layer_name: countries
  }
  dimension: loyaltytier {
    group_label: "Customer Info"
    label: "Loyalty Tier"
    description: "The customer's current loyalty program tier."
    type: string
    sql: ${TABLE}.loyaltytier ;;
  }
  dimension_group: customer_registrationdate {
    group_label: "Customer Info"
    label: "Customer Registration"
    description: "The date the customer registered their account."
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
    description: "The name of the store where the transaction occurred."
    type: string
    sql: ${TABLE}.storename ;;
  }
  dimension: store_city {
    group_label: "Store Info"
    label: "Store City"
    description: "The city where the store is located."
    type: string
    sql: ${TABLE}.store_city ;;
  }
  dimension: store_country {
    group_label: "Store Info"
    label: "Store Country"
    description: "The country where the store is located."
    type: string
    sql: ${TABLE}.store_country ;;
  }
  dimension: store_region {
    group_label: "Store Info"
    label: "Store Region"
    description: "The region where the store is located."
    type: string
    sql: ${TABLE}.store_region ;;
  }
  dimension: latitude {
    hidden: yes
    description: "The latitude coordinate of the store."
    type: number
    sql: ${TABLE}.latitude ;;
  }
  dimension: longitude {
    hidden: yes
    description: "The longitude coordinate of the store."
    type: number
    sql: ${TABLE}.longitude ;;
  }

  # Dimension: Location Mapping
  dimension: store_location {
    group_label: "Store Info"
    label: "Store Map Location"
    description: "The geographic location of the store for mapping purposes."
    type: location
    sql_latitude: ${latitude} ;;
    sql_longitude: ${longitude} ;;
  }

  # --- Product & Order Info (Grouped) ---
  dimension: brand {
    group_label: "Product Info"
    label: "Brand"
    description: "The brand of the product purchased."
    type: string
    sql: ${TABLE}.brand ;;
  }
  dimension: category {
    group_label: "Product Info"
    label: "Category"
    description: "The category of the product purchased."
    type: string
    sql: ${TABLE}.category ;;
  }
  dimension: productname {
    group_label: "Product Info"
    label: "Product Name"
    description: "The name of the product purchased."
    type: string
    sql: ${TABLE}.productname ;;
  }
  dimension: saleschannelname {
    group_label: "Order Info"
    label: "Sales Channel"
    description: "The channel through which the sale was made (e.g., Online, In-store)."
    type: string
    sql: ${TABLE}.saleschannelname ;;
  }
  dimension: paymenttypename {
    group_label: "Order Info"
    label: "Payment Type"
    description: "The method of payment used for the transaction."
    type: string
    sql: ${TABLE}.paymenttypename ;;
  }

  # --- Financial Dimensions (Hidden from UI, used for Measures) ---
  dimension: product_cost {
    hidden: yes
    description: "The cost to the company for the product."
    type: number
    sql: ${TABLE}.product_cost ;;
  }
  dimension: product_master_price {
    hidden: yes
    description: "The base price of the product."
    type: number
    sql: ${TABLE}.product_master_price ;;
  }
  dimension: quantity {
    hidden: yes
    description: "The number of items purchased in the transaction."
    type: number
    sql: ${TABLE}.quantity ;;
  }
  dimension: totalprice {
    hidden: yes
    description: "The total price paid for the items in the transaction."
    type: number
    sql: ${TABLE}.totalprice ;;
  }
  dimension: discountamount {
    hidden: yes
    description: "The total discount applied to the transaction."
    type: number
    sql: ${TABLE}.discountamount ;;
  }
  dimension: shippingcost {
    hidden: yes
    description: "The cost of shipping for the transaction."
    type: number
    sql: ${TABLE}.shippingcost ;;
  }
  dimension: taxamount {
    hidden: yes
    description: "The total tax amount for the transaction."
    type: number
    sql: ${TABLE}.taxamount ;;
  }

  # Gross Profit
  dimension: gross_profit {
    group_label: "Financials"
    label: "Gross Profit"
    description: "Total Price minus Discount Amount and Product Cost (multiplied by quantity)."
    type: number
    value_format_name: usd
    sql: ${totalprice} - ${discountamount} - (${product_cost} * ${quantity}) ;;
  }

  # --- Measures ---
  measure: count {
    label: "Total Transactions"
    description: "The total number of individual transactions."
    type: count
    drill_fields: [transaction_details*]
  }

  measure: total_revenue {
    label: "Total Revenue"
    description: "Sum of total price minus discounts for all transactions."
    type: sum
    sql: ${totalprice} - ${discountamount} ;;
    value_format_name: usd_0
    drill_fields: [transaction_details*]
  }

  measure: total_gross_profit {
    label: "Total Gross Profit"
    description: "Sum of gross profit across all transactions."
    type: sum
    sql: ${gross_profit} ;;
    value_format_name: usd_0
    drill_fields: [transaction_details*]
  }

  measure: total_quantity_sold {
    label: "Total Quantity Sold"
    description: "The total number of units sold across all transactions."
    type: sum
    sql: ${quantity} ;;
    drill_fields: [transaction_details*]
  }

  measure: average_order_value {
    label: "Average Order Value (AOV)"
    description: "Average revenue (net of discounts) generated per transaction."
    type: average
    sql: ${totalprice} - ${discountamount} ;;
    value_format_name: usd
    drill_fields: [transaction_details*]
  }

  measure: gross_margin_percentage {
    label: "Gross Margin %"
    description: "Total Gross Profit divided by Total Revenue."
    type: number
    sql: 1.0 * ${total_gross_profit} / NULLIF(${total_revenue}, 0) ;;
    value_format_name: percent_1
  }

  measure: total_lost_revenue {
    group_label: "Financials"
    label: "Total Lost Revenue"
    description: "Sum of revenue (net of discounts) for transactions older than 30 days with no shipment status."
    type: sum
    sql: ${totalprice} - ${discountamount} ;;
    filters: [is_lost_revenue: "yes"]
    value_format_name: usd_0
    drill_fields: [transaction_details*]
  }

  measure: lost_revenue_count {
    group_label: "Financials"
    label: "Lost Revenue Count"
    description: "Number of transactions older than 30 days with no shipment status."
    type: count
    filters: [is_lost_revenue: "yes"]
    drill_fields: [transaction_details*]
  }

  measure: unique_customers {
    label: "Total Unique Customers"
    description: "The number of distinct customers who have made transactions."
    type: count_distinct
    sql: ${customerid} ;;
    drill_fields: [customer_name, customer_city, customer_country, total_revenue]
  }

  dimension: shipment_status {
    label: "Shipment status"
    description: "The current status of the shipment (e.g., Shipped, Delayed)."
    sql: ${TABLE}.shipment_status;;
  }

  dimension: is_lost_revenue {
    group_label: "Financials"
    label: "Is Lost Revenue?"
    description: "True if the transaction occurred more than 30 days ago but shipment status is null."
    type: yesno
    sql: DATE_DIFF(CURRENT_DATE(), ${transaction_date}, DAY) > 30 AND ${shipment_status} IS NULL ;;
  }
  dimension: shippingmethod {
    label: "Shipping method"
    description: "The method used for shipping (e.g., Standard, Express)."
    sql: ${TABLE}.shipmentmethod;;
  }

  dimension: distribution_center_city {
    label: "Distribution Center"
    description: "The city of the distribution center that handled the shipment."
    sql: ${TABLE}.distribution_center_city ;;
  }

  measure: delayed_order_count {
    label: "Delayed Order Count"
    description: "The number of orders with a 'Delayed' shipment status."
    type: count
    filters: [shipment_status: "Delayed"]
    drill_fields: [transaction_details*]
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
