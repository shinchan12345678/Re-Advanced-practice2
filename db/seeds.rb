# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# (1..5).each do |i|
#   User.create(name: "test#{i}",email: "#{i*3}@#{i*3}",encrypted_password: "#{i*6}",introduction: "#{i*5}")
# end

(1..5).each do |i|
  Category.create(category_name: "test#{i}")
end

(1..5).each do |i|
  (1..5).each do |t|
    Book.create(user_id: t,title: "Star Wars#{i}",body: "seed-test",:created_at => Time.current.at_end_of_day - rand(10).days,rate: rand(5),category_id: rand(1..5))
  end
end