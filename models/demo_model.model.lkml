# Define the database connection to be used for this model.
connection: "analytics"

# include all the views
include: "/views/**/*.view.lkml"

explore: order_custom_derived_table {}

explore: orders {
  join: returns{
    sql_on: ${orders.order_id} =${returns.order_id} ;;
    type: inner
    relationship:  one_to_one
  }
}
