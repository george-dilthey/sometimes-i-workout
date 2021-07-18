# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(first_name: "George", last_name: "Dilthey", email: "george@george.com", password: "12345")

User.create(first_name: "Felix", last_name: "Dilthey", email: "felix@george.com", password: "12345" )

User.create(first_name: "Emily", last_name: "Eilertsen", email: "emily@emily.com", password: "12345")

User.create(first_name: "Cleo", last_name: "Eilertsen", email: "cleo@emily.com", password: "12345")

Workout.create(name: "Tappan Zee", date: "Sat, 17 Jul 2021 21:16:24 -0400",  distance: 5, type: "Bike", public: true, user_id: 1, elapsed_time: 25)

Workout.create(name: "Central Park", date: "Sat, 17 Jul 2021 21:16:24 -0400", distance: 6, type: "Bike", public: true, user_id: 2, elapsed_time: 25)

Segment.create(name: "River Road", distance: 2)

Segment.create(name: "Horse Run", distance: 4)