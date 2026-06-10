view: product_reviews {
  sql_table_name: `looker-private-demo.cymbal_gadgets.product_reviews` ;;

  # --- Hidden IDs ---
  dimension: reviewid {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.reviewid ;;
  }
  dimension: productid {
    hidden: yes
    type: number
    sql: ${TABLE}.productid ;;
  }

  # --- Dimensions ---
  dimension: productname {
    label: "Product Name (Review)"
    type: string
    sql: ${TABLE}.productname ;;
  }
  dimension: reviewername {
    label: "Reviewer Name"
    type: string
    sql: ${TABLE}.reviewername ;;
  }
  dimension: reviewtext {
    label: "Review Content"
    type: string
    sql: ${TABLE}.reviewtext ;;
  }
  dimension_group: reviewdate {
    label: "Review"
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.reviewdate ;;
  }

  # --- Dimensions ---
  dimension: rating {
    label: "Rating (1-5)"
    type: number
    sql: ${TABLE}.rating ;;
    html: @{star_rating_html} ;;
  }

  dimension: rating_tier {
    type: tier
    tiers: [1, 2, 3, 4, 5]
    style: integer
    sql: FLOOR(${rating}) ;;
  }

  dimension: is_positive_review {
    label: "Is Positive Review?"
    description: "Returns Yes if the rating is 4 or 5."
    type: yesno
    sql: ${rating} >= 4 ;;
  }

  # --- Measures ---
  measure: count {
    label: "Count"
    type: count
    drill_fields: [review_details*]
  }

  measure: average_rating {
    label: "Average Rating"
    description: "The average customer rating for the product."
    type: average
    sql: ${rating} ;;
    value_format_name: decimal_2
    drill_fields: [review_details*]
  }

  measure: count_positive_reviews {
    label: "Total Positive Reviews"
    description: "Count of reviews with a rating of 4 or 5."
    type: count
    filters: [is_positive_review: "Yes"]
    drill_fields: [review_details*]
  }

  set: review_details {
    fields: [reviewid, productname, reviewdate_date, reviewtext, rating]
  }
}
