# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Consent.first_or_create(key: 'email')

(1..25).each do |i|
  user = User.new username: Faker::Internet.user_name, email: Faker::Internet.email
  if rand(1..25) % 3 == 0
    user.birthdate = Date.today
  else
    user.birthdate = Faker::Date.between_except(from: 30.year.ago, to: 1.day.ago, excepted: Date.today)
  end
  user.consents << Consent.last if i.odd?
  user.save
end
