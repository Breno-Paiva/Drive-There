# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Vehicle.delete_all
Reservation.delete_all

Vehicle.create!(location: "NYC", car_type: "Compact", make: "Honca", model: "Fit", year: 2008, rental_cost: 85)
