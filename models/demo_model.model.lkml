# Define the database connection to be used for this model.
connection: "analytics"

# include all the views
include: "/views/**/*.view.lkml"

explore: orders {}
