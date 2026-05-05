view: product_reviews {
  sql_table_name: `looker-private-demo.cymbal_gadgets.product_reviews` ;;

  # --- Hidden IDs ---
  dimension: pk1_review_id {
    primary_key: yes
    hidden: yes
    type: number
    group_label: "IDs"
    description: "Primary key: Unique identifier for each product review."
    sql: ${TABLE}.reviewid ;;
  }
  dimension: productid {
    hidden: yes
    type: number
    group_label: "IDs"
    description: "Identifier for the product being reviewed."
    sql: ${TABLE}.productid ;;
  }

  # --- Dimensions ---
  dimension: productname {
    label: "Product Name (Review)"
    description: "The name of the product as it appears in the review."
    type: string
    sql: ${TABLE}.productname ;;
  }
  dimension: reviewername {
    label: "Reviewer Name"
    description: "The name of the customer who provided the review."
    type: string
    sql: ${TABLE}.reviewername ;;
  }
  dimension: reviewtext {
    label: "Review Content"
    description: "The full text content of the customer review."
    type: string
    sql: ${TABLE}.reviewtext ;;
  }
  dimension_group: reviewdate {
    label: "Review"
    description: "The date and time the review was submitted."
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.reviewdate ;;
  }

  # --- Dimensions ---
  dimension: rating {
    label: "Rating (1-5)"
    description: "The numerical rating provided by the customer, from 1 to 5."
    type: number
    sql: ${TABLE}.rating ;;
    html: @{star_rating_html} ;;
  }

  dimension: rating_tier {
    label: "Rating Tier"
    description: "The rating rounded down to the nearest integer for tiering."
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
    label: "Total Reviews"
    description: "The total number of product reviews."
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
    fields: [pk1_review_id, productname, reviewdate_date, reviewtext, rating]
  }
}
