# Set up for the application and database. DO NOT CHANGE. #############################
require "sequel"                                                                      #
connection_string = ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite3"  #
DB ||= Sequel.connect(connection_string)                                              #
#######################################################################################

# Database schema - this should reflect your domain model
# DB.create_table! :events do
#   primary_key :id
#   String :title
#   String :description, text: true
#   String :date
#   String :location
# end
# DB.create_table! :rsvps do
#   primary_key :id
#   foreign_key :event_id
#   Boolean :going
#   String :name
#   String :email
#   String :comments, text: true
# end

# New domain model - adds users
DB.create_table! :events do
  primary_key :id
  String :title
  String :description, text: true
  String :date
  String :location
end
DB.create_table! :rsvps do
  primary_key :id
  foreign_key :event_id
  foreign_key :user_id
  Boolean :going
  String :comments, text: true
end
DB.create_table! :users do
  primary_key :id
  String :name
  String :email
  String :password
end

# Insert initial (seed) data
events_table = DB.from(:events)

events_table.insert(title: "Rescue grocery perishables", 
                    description: "Every day of the week, Valli's offers packages of fresh produce that are close to losing their freshness. Each package costs $1.49, content of the packages vary depending on what needs to go!",
                    location: "Valli Produce, Evanston")

events_table.insert(title: "Recycle your grocery plastic bags", 
                    description: "Jewel Osco collects used plastic grocery bags and gives them a new meaningful life.",
                    location: "Jewel Osco, Evanston")

                    puts "success!"