# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                          :uuid             not null, primary key, indexed => [encrypted_email, encrypted_email_iv]
#  birthdate                   :date             not null
#  encrypted_email             :string           indexed => [id, encrypted_email_iv]
#  encrypted_email_bidx        :string           indexed
#  encrypted_email_iv          :string           indexed => [id, encrypted_email]
#  encrypted_password          :string
#  encrypted_preferred_name    :string
#  encrypted_preferred_name_iv :string
#  encrypted_username          :string
#  encrypted_username_iv       :string
#  locale                      :string           default("en"), not null
#  uuid                        :uuid             indexed
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#
# Indexes
#
#  index_users_on_encrypted_email_bidx  (encrypted_email_bidx)
#  index_users_on_uuid                  (uuid) UNIQUE
#  user_email                           (id,encrypted_email,encrypted_email_iv)
#

FactoryBot.define do
  factory :user do
    sequence(:username) {|n| "username#{n}" }
    sequence(:email) {|n| "email#{n}@domain.com" }
    sequence(:preferred_name) {|n| "preferred_name#{n}" }
    birthdate { FFaker::Time.date }
  end

  factory :birthday_user, class: User do
    sequence(:username) {|n| "birthday_username#{n}" }
    sequence(:email) {|n| "birthday_email#{n}@domain.com" }
    sequence(:preferred_name) {|n| "birthday_preferred_name#{n}" }
    birthdate { Time.zone.now }
  end

  factory :no_birthday_user, class: User do
    sequence(:username) {|n| "no_birthday_username#{n}" }
    sequence(:email) {|n| "no_birthday_email#{n}@domain.com" }
    sequence(:preferred_name) {|n| "no_birthday_preferred_name#{n}" }
    birthdate { Time.zone.now - 22.days }
  end
end
