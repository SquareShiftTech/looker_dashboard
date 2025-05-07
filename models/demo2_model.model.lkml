connection: "analytics"

include: "/views/*.view.lkml"

datagroup: demo_pdt {
  max_cache_age: "1 hours"
  sql_trigger:SELECT CURRENT_TIMESTAMP() ;;
  interval_trigger: "1 hours"
}

explore: orders_data {
  label : "Orders Analysis"

  persist_with: demo_pdt

  access_filter: {
    field: region.region
    user_attribute: region
  }

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
