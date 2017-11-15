# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = User.create(password: "12345678", email: "admin@test.com", password_confirmation: "12345678")
user1.add_role :admin

user2 = User.create(password: "12345678", email: "super_admin@test.com", password_confirmation: "12345678")
user2.add_role :super_admin


