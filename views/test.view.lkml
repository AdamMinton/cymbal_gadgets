view: test {
  # Default view for testing - updated
  sql_table_name: `looker-private-demo.cymbal_gadgets.test` ;;

  # --- Hidden IDs ---
  dimension: id {
    primary_key: yes
    type: number
    description: "The unique identifier for the test record."
    sql: ${TABLE}.id ;;
  }

  # --- Dimensions ---
  dimension: name {
    label: "Test Name"
    type: string
    sql: ${TABLE}.name ;;
  }

  # --- Measures ---
  measure: count {
    label: "Total Count"
    type: count
    drill_fields: [id, name]
  }
}
