connection: "bq_faa"

include: "/views/*"
include: "/dashboards/*"

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
  join: customer_spending_ndt {
    view_label: "Customer Loyalty & Spending (NDT)"
    sql_on: ${transactions.customerid} = ${customer_spending_ndt.customerid} ;;
    relationship: many_to_one
  }
  join: customer_loyalty_tiers_ndt {
    view_label: "Customer Tier Rankings (NDT)"
    sql_on: ${transactions.customerid} = ${customer_loyalty_tiers_ndt.customerid} ;;
    relationship: many_to_one
  }
}

explore: customer_spending_ndt {
  label: "💎 Cymbal Gadgets: Customer Loyalty & Spending"
  description: "Customer-level spending analysis, revenue percentile thresholds (Top 1%, 5%, 10%), and loyalty tier rankings."

  join: customer_loyalty_tiers_ndt {
    view_label: "Customer Tier Rankings (NDT)"
    sql_on: ${customer_spending_ndt.customerid} = ${customer_loyalty_tiers_ndt.customerid} ;;
    relationship: one_to_one
  }
}

explore: product_reviews {
  label: "🛍️ Cymbal Gadgets: Product Reviews"
}

