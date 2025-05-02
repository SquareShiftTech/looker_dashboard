# The name of this view in Looker is "Person"
view: person {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `Super_Store_Sales.person` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Region" in Explore.

  dimension: region {
    type: string
    sql: ${TABLE}.Region ;;
  }

  dimension: regional_manager {
    type: string
    sql: ${TABLE}.`Regional Manager` ;;
  }
  measure: count {
    type: count
  }
}
