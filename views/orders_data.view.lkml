# The name of this view in Looker is "Orders Data"
view: orders_data {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `Super_Store_Sales.orders_data` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Category" in Explore.

  dimension: category {
    type: string
    sql: ${TABLE}.Category ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.City ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.Country ;;
  }

  dimension: customer_id {
    type: string
    sql: ${TABLE}.Customer_ID ;;
  }

  dimension: customer_name {
    type: string
    sql: ${TABLE}.Customer_Name ;;
  }

  dimension: discount {
    type: number
    sql: ${TABLE}.Discount ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: order {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Order_Date ;;
  }

  dimension: order_id {
    type: string
    sql: ${TABLE}.Order_ID ;;
  }

  dimension: postal_code {
    type: string
    sql: ${TABLE}.Postal_Code ;;
  }

  dimension: product_id {
    type: string
    sql: ${TABLE}.Product_ID ;;
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}.Product_Name ;;
  }
  dimension: region {
    type: string
    sql: ${TABLE}.Region ;;
  }

  dimension: region_id {
    type: number
    sql: ${TABLE}.Region_ID ;;
  }

  dimension: segment {
    type: string
    sql: ${TABLE}.Segment ;;
  }

  dimension_group: ship {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Ship_Date ;;
  }

  dimension: ship_mode {
    type: string
    sql: ${TABLE}.Ship_Mode ;;
  }
  dimension: cy {
    type: yesno
    hidden: yes
    sql: EXTRACT(YEAR FROM ${order_date}) = (
         SELECT MAX(EXTRACT(YEAR FROM ${order_date})) FROM ${TABLE}
       );;
  }
  dimension: py {
    hidden: yes
    type: yesno
    sql: EXTRACT(YEAR FROM ${order_date}) = (
         SELECT MAX(EXTRACT(YEAR FROM ${order_date})) - 1 FROM ${TABLE}
       );;
  }
  dimension: state {
    type: string
    sql: ${TABLE}.State ;;
  }

  dimension: sub_category {
    type: string
    sql: ${TABLE}.Sub_Category ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}.Year ;;
  }
  measure: count {
    type: count
    drill_fields: [customer_name, product_name]
  }
  measure: sales {
    type: sum
    value_format: "0,\" K\""
    sql: ${TABLE}.Sales ;;
  }
  measure: profit {
    type: sum
    sql: ${TABLE}.Profit ;;
    value_format: "#,##0"
  }
  measure: quantity {
    type: sum
    sql: ${TABLE}.Quantity ;;
  }
  measure: sales_cy {
    type: sum
    sql: IFNULL(CASE WHEN ${cy} THEN ${TABLE}.Sales END, 0) ;;
    value_format: "#,##0"
  }
  measure: sales_py {
    type: sum
    sql: IFNULL(CASE WHEN ${py} THEN ${TABLE}.Sales END, 0) ;;
    value_format: "#,##0"
  }
  measure: profit_cy {
    type: sum
    sql:IFNULL(CASE WHEN ${cy} THEN ${TABLE}.Profit END, 0) ;;
    value_format: "#,##0"
  }
  measure: profit_py {
    type: sum
    sql: IFNULL(CASE WHEN ${py} THEN ${TABLE}.Profit END, 0) ;;
    value_format: "#,##0"
  }
  measure: profit_margin {
    type: sum
    label: "Profit Margin"
    sql: CASE WHEN ${TABLE}.Sales != 0 THEN ${TABLE}.Profit / ${TABLE}.Sales ELSE 0 END ;;
    value_format_name: "decimal_2"
  }
  measure: sales_rank {
    type: number
    sql: RANK() OVER (ORDER BY ${sales} DESC) ;;
    label: "Sales Rank"
  }
  measure: rank_lod {
    type: number
    sql: RANK() OVER (
          PARTITION BY ${region}
          ORDER BY SUM(${TABLE}.sales) DESC
        ) ;;
    value_format_name: decimal_0
  }
  measure: conditional_formatted_profit {
    type: sum
    sql: ${TABLE}.Profit ;;
    html:
    {% assign formatted_profit = value | round: 0 %}
    {% if value < -9000 %}
      <span style="color: #eb304c;">{{ formatted_profit }}</span>
    {% elsif value < 0 %}
      <span style="color: #E8710A;">{{ formatted_profit }}</span>
    {% elsif value == 0 %}
      <span style="color: #80868B;">{{ formatted_profit }}</span>
    {% elsif value < 10000 %}
      <span style="color: #12B5CB;">{{ formatted_profit }}</span>
    {% else %}
      <span style="color:#1b7ecc;">{{ formatted_profit }}</span>
    {% endif %};;
  }
  measure: conditional_formatted_sales {
    type: number
    sql: SUM(${TABLE}.Sales) ;;
    html:
    {% assign formatted_sales = value | round: 0 %}
    {% if profit._value < -5000 %}
    <span style="color: #eb304c;">{{ formatted_sales }}</span>
    {% elsif profit._value < 0 %}
    <span style="color: #E8710A;">{{ formatted_sales }}</span>
    {% elsif profit._value == 0 %}
    <span style="color: #80868B;">{{ formatted_sales }}</span>
    {% elsif profit._value < 10000 %}
    <span style="color: #12B5CB;">{{ formatted_sales }}</span>
    {% else %}
    <span style="color: #1b7ecc;">{{ formatted_sales }}</span>
    {% endif %};;
  }
  dimension: order_month_name {
    type: string
    sql: FORMAT_DATE('%B', DATE(${TABLE}.Order_Date)) ;;
  }
  dimension: order_month_number {
    type: number
    sql: EXTRACT(MONTH FROM DATE(${TABLE}.Order_Date)) ;;
  }
  measure: sales_percentage_of_total {
    type: number
    sql: ${sales} / SUM(${sales}) OVER () ;;
    value_format_name: "decimal_2"
    label: "Sales Percentage of Total"
  }
}
