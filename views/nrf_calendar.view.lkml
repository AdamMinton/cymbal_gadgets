view: nrf_calendar {
  sql_table_name: `adamminton-sandbox.custom_calendars.nrf_calendar` ;;
  label: "NRF Fiscal Calendar"
  # description: "National Retail Federation (NRF) 4-5-4 calendar for retail analysis."

  # --- Primary Key ---
  dimension: pk1_nrf_calendar {
    primary_key: yes
    hidden: yes
    type: date
    sql: ${TABLE}.calendar_date ;;
  }
  

  # --- Dates ---
  dimension_group: calendar {
    label: "Calendar"
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.calendar_date ;;
  }

  # --- Fiscal Information ---
  dimension: fiscal_year {
    group_label: "Fiscal Information"
    type: number
    sql: ${TABLE}.fiscal_year ;;
  }

  dimension: fiscal_quarter {
    group_label: "Fiscal Information"
    type: number
    sql: ${TABLE}.fiscal_quarter ;;
  }

  dimension: fiscal_period {
    group_label: "Fiscal Information"
    type: number
    sql: ${TABLE}.fiscal_period ;;
  }

  dimension: fiscal_week {
    group_label: "Fiscal Information"
    type: number
    sql: ${TABLE}.fiscal_week ;;
  }

  dimension: fiscal_day {
    group_label: "Fiscal Information"
    type: number
    sql: ${TABLE}.fiscal_day ;;
  }

  # --- Measures ---
  measure: count {
    type: count
    drill_fields: [calendar_date, fiscal_year, fiscal_quarter, fiscal_period]
  }
}
# End of file
