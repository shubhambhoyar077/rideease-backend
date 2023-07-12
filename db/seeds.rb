# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user1 = User.create(name: "John", email: "john@gmail.com")
user2 = User.create(name: "Tina", email: "tina@gmail.com")
user3 = User.create(name: "Rock", email: "rock@gmail.com")

service1 = Service.create(name: "Bugatti",details: "test details",
   image: "https://imageio.forbes.com/specials-images/imageserve/5f962df3991e5636a2f68758/0x0.jpg?format=jpg&crop=812,457,x89,y103,safe&width=1200")

service2 = Service.create(name: "Aston Martin",details: "test details",
    image: "https://carwow-uk-wp-3.imgix.net/18015-MC20BluInfinito-scaled-e1666008987698.jpg")
service3 = Service.create(name: "BMW",details: "test details",
    image: "https://www.autocar.co.uk/sites/autocar.co.uk/files/images/car-reviews/first-drives/legacy/99-best-luxury-cars-2023-bmw-i7-lead.jpg")


Reservation.create(date: "2020-02-02", city: 'test', user: user1, service: service1)
Reservation.create(date: "2020-02-02", city: 'test', user: user2, service: service2)
Reservation.create(date: "2020-02-02", city: 'test', user: user2, service: service2)
Reservation.create(date: "2020-02-02", city: 'test', user: user3, service: service3)

