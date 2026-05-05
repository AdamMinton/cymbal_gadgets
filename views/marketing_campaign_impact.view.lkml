view: marketing_campaign_impact {
  sql_table_name: `looker-private-demo.cymbal_gadgets.marketing_campaign_impact` ;;

  # --- Hidden IDs ---
  dimension: pk1_sales_id {
    primary_key: yes
    hidden: yes
    type: number
    group_label: "IDs"
    description: "Primary key: Unique identifier for the sale associated with this campaign impact."
    sql: ${TABLE}.salesid ;;
  }
  dimension: customerid {
    hidden: yes
    type: number
    group_label: "IDs"
    description: "Identifier for the customer associated with this campaign impact."
    sql: ${TABLE}.customerid ;;
  }
  dimension: productid {
    hidden: yes
    type: number
    group_label: "IDs"
    description: "Identifier for the product associated with this campaign impact."
    sql: ${TABLE}.productid ;;
  }

  # --- Dimensions ---
  dimension: campaignname {
    group_label: "Campaign Details"
    label: "Campaign Name"
    description: "The name of the marketing campaign."
    type: string
    sql: ${TABLE}.campaignname ;;
  }
  dimension: eventname {
    group_label: "Campaign Details"
    label: "Event Name"
    description: "The name of the specific marketing event."
    type: string
    sql: ${TABLE}.eventname ;;
  }
  dimension: durationdays {
    group_label: "Campaign Details"
    label: "Duration (Days)"
    description: "The duration of the campaign in days."
    type: number
    sql: ${TABLE}.durationdays ;;
  }
  dimension_group: transaction {
    label: "Campaign Transaction"
    description: "The date and time of the transaction associated with the campaign."
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.transaction_date ;;
  }

  # --- Metrics (Base) ---
  dimension: campaign_impact {
    hidden: yes
    description: "Raw impact metric for the campaign."
    type: number
    sql: ${TABLE}.campaign_impact ;;
  }
  dimension: event_impact {
    hidden: yes
    description: "Raw impact metric for the event."
    type: number
    sql: ${TABLE}.event_impact ;;
  }
  dimension: totalprice {
    hidden: yes
    description: "Total price of the transaction in this campaign."
    type: number
    sql: ${TABLE}.totalprice ;;
  }

  # --- Measures ---
  measure: count {
    label: "Total Campaign Events"
    description: "The total number of marketing campaign events."
    type: count
    drill_fields: [campaign_details*]
  }

  measure: total_campaign_impact {
    label: "Total Campaign Impact"
    description: "The sum of the campaign impact metric across all campaigns."
    type: sum
    sql: ${campaign_impact} ;;
    value_format_name: decimal_2
    drill_fields: [campaign_details*]
  }

  measure: total_event_impact {
    label: "Total Event Impact"
    description: "The sum of the event impact metric across all campaigns."
    type: sum
    sql: ${event_impact} ;;
    value_format_name: decimal_2
    drill_fields: [campaign_details*]
  }

  measure: total_sales {
    label: "Total Sales"
    description: "The sum of all sales associated with campaigns."
    type: sum
    sql: ${totalprice} ;;
    value_format_name: usd
    drill_fields: [campaign_details*]
  }

  measure: average_duration_days {
    label: "Average Campaign Duration"
    description: "The average duration of campaigns in days."
    type: average
    sql: ${durationdays} ;;
    value_format_name: decimal_1
    drill_fields: [campaign_details*]
  }

  set: campaign_details {
    fields: [campaignname, eventname, durationdays, total_campaign_impact]
  }
}
