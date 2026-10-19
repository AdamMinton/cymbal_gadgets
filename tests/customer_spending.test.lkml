test: customer_spending_thresholds_are_valid {
  explore_source: customer_spending {
    column: top_1_pct_revenue_threshold {}
    column: top_5_pct_revenue_threshold {}
    column: top_10_pct_revenue_threshold {}
    column: median_customer_lifetime_revenue {}
  }

  assert: top_1_greater_than_top_5 {
    expression: ${customer_spending.top_1_pct_revenue_threshold} > ${customer_spending.top_5_pct_revenue_threshold} ;;
  }

  assert: top_5_greater_than_top_10 {
    expression: ${customer_spending.top_5_pct_revenue_threshold} > ${customer_spending.top_10_pct_revenue_threshold} ;;
  }

  assert: top_10_greater_than_median {
    expression: ${customer_spending.top_10_pct_revenue_threshold} > ${customer_spending.median_customer_lifetime_revenue} ;;
  }
}

test: customer_spending_reconciles_total_customers_and_revenue {
  explore_source: customer_spending {
    column: count_customers {}
    column: total_customer_revenue {}
    column: top_1_pct_customer_count {}
    column: top_5_pct_customer_count {}
    column: top_10_pct_customer_count {}
  }

  assert: total_customers_matches_source {
    expression: ${customer_spending.count_customers} = 76177 ;;
  }

  assert: top_1_pct_count_is_one_percent {
    expression: ${customer_spending.top_1_pct_customer_count} = 762 ;;
  }

  assert: top_5_pct_count_is_five_percent {
    expression: ${customer_spending.top_5_pct_customer_count} = 3809 ;;
  }

  assert: top_10_pct_count_is_ten_percent {
    expression: ${customer_spending.top_10_pct_customer_count} = 7618 ;;
  }
}

