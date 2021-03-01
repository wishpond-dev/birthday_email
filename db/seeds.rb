# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Consent.first_or_create(key: 'email')

User.destroy_all

User.transaction do
  [
    {
      email: 'pendev8@gmail.com',
      preferred_name: 'Sujit',
      username: 'sujit1010',
      locale: 'dz',
      birthdate: '1990-02-27'
    },
    {
      email: 'sujit_sampang@live.com',
      preferred_name: 'Foden',
      username: 'foden007',
      locale: 'en',
      birthdate: '1990-05-11'
    },
    {
      email: 'doubles507@gmail.com',
      preferred_name: 'Lewandowski',
      username: 'lewandoski11',
      locale: 'de',
      birthdate: '1990-02-27'
    },
    {
      email: 'doubles507+2@gmail.com',
      preferred_name: 'Buffon',
      username: 'buffon12',
      locale: 'it',
      birthdate: '1990-02-27'
    },
    {
      email: 'doubles507+1@gamil.com',
      preferred_name: 'Mbappé',
      username: 'mbappe13',
      locale: 'fr',
      birthdate: '1990-02-27'
    }
  ].each do |user|
    User.create!(user)
  end
end

UserConsent.destroy_all

consent_id = Consent.first.id
user_consent_obj = []
User.all.each do |usr|
  new_obj = {
    user_id: usr.id,
    consent_id: consent_id,
    consented: true
  }
  user_consent_obj.push(new_obj)
end

UserConsent.transaction do
  user_consent_obj.each do |user_consent|
    UserConsent.create!(user_consent)
  end
end