# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user=User.new(username: 'admin4', email: 'admin4@gmail.com', password: '12345678', role: :admin)
user.confirm
user.save
# User.create!(username: 'admin3', email: 'admin3@gmail.com', password: '12345678', password_confirmation: '12345678', role: :admin) if Rails.env.development?