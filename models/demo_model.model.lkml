# Define the database connection to be used for this model.
connection: "analytics"

# include all the views
include: "/views/**/*.view.lkml"

explore: order_custom_derived_table
{
label : "Order Details with Region & Returns"
}
explore: orders {
  label : "Orders & Returns"
  join: returns{
    sql_on: ${orders.order_id} =${returns.order_id} ;;
    type: inner
    relationship:  one_to_one
  }
}

explore: orders_data {
  label : "Orders Data"
  join: user_access{
    sql_on: ${orders_data.region_id} =${user_access.region_id} ;;
    type: inner
    relationship:  one_to_one
  }
  join: region{
    sql_on: ${orders_data.region_id} =${region.id} ;;
    type: inner
    relationship:  one_to_one
}
  join: users{
    sql_on: ${orders_data.region_id} =${users.region_id} ;;
    type: inner
    relationship:  one_to_one
}
  join: orders{
    sql_on: ${orders_data.product_id} =${orders.product_id} ;;
    type: inner
    relationship:  one_to_one
}
  join: region_east{
    sql_on: ${orders_data.product_id} =${region_east.product_id} ;;
    type: inner
    relationship:  one_to_one
}
  join: region_west{
    sql_on: ${orders_data.product_id} =${region_west.product_id} ;;
    type: inner
    relationship:  one_to_one

    }
}
