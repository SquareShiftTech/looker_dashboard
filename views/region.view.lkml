view: region {
  sql_table_name: `sqsh-looker-project.Super_Store_Sales.region` ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }
  dimension: region {
    type: string
    sql: ${TABLE}.Region ;;
  }
  measure: count {
    type: count
    drill_fields: [id, users.count]
  }
}
