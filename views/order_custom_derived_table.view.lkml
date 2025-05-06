
view: order_custom_derived_table{
  derived_table: {
    sql: select * from `sqsh-looker-project.Super_Store_Sales.Order_Details` od inner join `sqsh-looker-project.Super_Store_Sales.Returns` re on od.Order_ID=re.Order_ID ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: order_id {
    type: string
    sql: ${TABLE}.Order_ID ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}.Region ;;
  }


  dimension: order_date {
    type: date
    datatype: date
    sql: ${TABLE}.Order_Date ;;
  }
  dimension_group: order_date_timeframes {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Order_Date ;;
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
  dimension: ship_date {
    type: date
    datatype: date
    sql: ${TABLE}.Ship_Date ;;
  }

  dimension: ship_mode {
    type: string
    sql: ${TABLE}.Ship_Mode ;;
  }

  dimension: customer_id {
    type: string
    sql: ${TABLE}.Customer_ID ;;
  }

  dimension: customer_name {
    type: string
    sql: ${TABLE}.Customer_Name ;;
  }

  dimension: segment {
    type: string
    sql: ${TABLE}.Segment ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.Country ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.City ;;
  }

  dimension: state {
    type: string
    map_layer_name: us_states
    sql: ${TABLE}.State ;;
  }

  dimension: postal_code {
    type: number
    sql: ${TABLE}.Postal_Code ;;
  }

  dimension: region_id {
    type: number
    sql: ${TABLE}.Region_ID ;;
  }

  dimension: product_id {
    type: string
    sql: ${TABLE}.Product_ID ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.Category ;;
  }

  dimension: sub_category {
    type: string
    sql: ${TABLE}.Sub_Category ;;
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}.Product_Name ;;
  }

  dimension: sales {
    type: number
    sql: ${TABLE}.Sales ;;
  }

  dimension: id {
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: returned {
    type: yesno
    sql: ${TABLE}.Returned ;;
  }

  dimension: order_id_1 {
    type: string
    sql: ${TABLE}.Order_ID_1 ;;
  }
  dimension: order_month_name {
    type: string
    sql: FORMAT_DATE('%B', DATE(${TABLE}.Order_Date)) ;;
  }
  measure: total_sales {
    type: sum
    sql: ${TABLE}.sales ;;
    value_format_name: "decimal_0"
  }
  measure: sales_rank {
    type: number
    sql: RANK() OVER (ORDER BY ${sales} DESC) ;;
    label: "Sales Rank"
    description: "Rank of Sales by Sub-Category or other grouping"
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
  measure: avg_profit_margin {
    type: average
    sql: CASE WHEN ${TABLE}.Sales != 0 THEN ${TABLE}.Profit / ${TABLE}.Sales ELSE 0 END ;;
    value_format_name: "percent_0"
    label: "Avg. Profit Margin"
  }
  measure: profit_margin {
    type: sum
    label: "Profit Margin"
    sql: CASE WHEN ${TABLE}.Sales != 0 THEN ${TABLE}.Profit / ${TABLE}.Sales ELSE 0 END ;;
    value_format_name: "decimal_2"
  }
  measure: count_custom_sql_query {
    type: count
    label: "Count of Custom SQL Query"
  }
  measure: discount {
    type: sum
    sql: ${TABLE}.discount ;;
    value_format_name: "percent_2"
  }
  measure: profit {
    type: sum
    sql: ${TABLE}.profit ;;
    value_format_name: "decimal_0"
  }
  measure: quantity {
    type: sum
    sql: ${TABLE}.quantity ;;
  }
  measure: profit_percentage {
    type: number
    sql: ${profit}/${total_sales} ;;
    value_format: "0%"
  }
  set: detail {
    fields: [
      order_id,
      order_date,
      ship_date,
      ship_mode,
      customer_id,
      customer_name,
      segment,
      country,
      city,
      state,
      postal_code,
      region_id,
      product_id,
      category,
      sub_category,
      product_name,
      sales,
      quantity,
      discount,
      profit,
      id,
      returned,
      order_id_1
    ]
  }
}
