connection: "bq_faa"

include: "/views/*"
include: "/dashboards/*"
include: "/tests/*.test.lkml"

datagroup: cymbal_gadgets_default_datagroup {
  max_cache_age: "1 hour"
}

persist_with: cymbal_gadgets_default_datagroup

explore: transactions {
  label: "🛍️ Cymbal Gadgets: Transactions & Sales"
  description: "Core explore for analyzing transactions, marketing impact, and product reviews."

  join: product_reviews {
    sql_on: ${transactions.productid} = ${product_reviews.productid} ;;
    relationship: many_to_many
  }
  join: marketing_campaign_impact {
    sql_on: ${transactions.salesid} = ${marketing_campaign_impact.salesid} ;;
    relationship: one_to_many
  }
  join: customer_spending {
    view_label: "Customer Spending & Loyalty (NDT)"
    sql_on: ${transactions.customerid} = ${customer_spending.customerid} ;;
    relationship: many_to_one
  }
  join: customer_loyalty_tiers {
    view_label: "Customer Tier Rankings (NDT)"
    sql_on: ${transactions.customerid} = ${customer_loyalty_tiers.customerid} ;;
    relationship: many_to_one
  }
}

explore: customer_spending {
  label: "💎 Cymbal Gadgets: Customer Spending & Loyalty"
  description: "Customer-level lifetime spending analysis, revenue percentile thresholds (Top 1%, Top 5%, Top 10%), and loyalty tier rankings."

  join: customer_loyalty_tiers {
    view_label: "Customer Tier Rankings (NDT)"
    sql_on: ${customer_spending.customerid} = ${customer_loyalty_tiers.customerid} ;;
    relationship: one_to_one
  }
}

explore: product_reviews {
  label: "🛍️ Cymbal Gadgets: Product Reviews"
}
