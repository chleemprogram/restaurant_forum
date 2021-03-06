# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#category
Category.destroy_all

category_list = [
  { name: "台式料理"},
  { name: "中式料理"},
  { name: "義大利式料理"},
  { name: "日式料理"},
  { name: "美式料理"},
  { name: "歐式料理"},
  { name: "素食料理"},
  { name: "複合式料理"}
]

category_list.each do |category|
  Category.create(name: category[:name])
end

puts "Category created!"

#Default admin
User.create(name: "root", email: "root@example.com", password: "12345678", role: "admin")
puts "Default admin created!"