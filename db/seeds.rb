# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all

Consent.first_or_create(key: 'email')

# Create Users
User.create! [
  {email: "test1@gmail.com", username: "test1", birthdate:"2000/#{Date.today.month}/#{Date.today.day}", locale: "pt"},
  {email: "test2@gmail.com", username: "test2", birthdate:"2000/#{Date.today.month}/#{Date.today.day}", locale: "en"},
  {email: "test3@gmail.com", username: "test3", birthdate:"2000/#{Date.today.month}/#{Date.today.day}", locale: "en"},
  {email: "test4@gmail.com", username: "test4", birthdate:"2000/#{Date.today.month}/#{Date.today.day}", locale: "es"}
]

User.all.each do |user|
  UserConsent.create(user_id: user.id, consent_id: Consent.first.id, up_to_date: true, consented: true)
end
