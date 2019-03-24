# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name:  "admin",
  email: "admin@mail.org",
  password:              "test_pass",
  password_confirmation: "test_pass",
  admin: true)

99.times do |n|
name  = Faker::Name.name
email = "example-#{n+1}@test.org"
password = "password"
User.create!(name:  name,
    email: email,
    password:              password,
    password_confirmation: password)
end

users = User.order(:created_at).take(6)
50.times do
  title = "title"
  content = Faker::Lorem.sentence(6)
  users.each { |user| user.posts.create!(title: title, content: content) }
end
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?