# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Vehicle.delete_all
Reservation.delete_all

x = Vehicle.create!(location: "NYC", car_type: "Compact", make: "Honda", model: "Fit", year: 2008, rental_cost: 85)
Reservation.create!(start_date: "2017-07-02", end_date: "2017-07-08", vehicle_id: x.id)
Reservation.create!(start_date: "2017-07-15", end_date: "2017-07-19", vehicle_id: x.id)
Reservation.create!(start_date: "2017-07-22", end_date: "2017-07-27", vehicle_id: x.id)
Vehicle.create!(location: "NYC", car_type: "Compact", make: "Honda", model: "Civic", year: 2008, rental_cost: 80)
Vehicle.create!(location: "NYC", car_type: "Compact", make: "Toyota", model: "Camry", year: 2008, rental_cost: 75)
