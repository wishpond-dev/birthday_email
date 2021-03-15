# frozen_string_literal: true

# rubocob:disable Layout/LineLength
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
#  index_user_on_birthdate_day_and_month  ((((date_part('day'::text, birthdate) || '-'::text) || date_part('month'::text
#  , birthdate))))
#  index_users_on_encrypted_email_bidx    (encrypted_email_bidx)
#  index_users_on_uuid                    (uuid) UNIQUE
#  user_email                             (id,encrypted_email,encrypted_email_iv)
#

FactoryBot.define do
  factory :user do
    sequence(:username) {|n| "username#{n}" }
    sequence(:email) {|n| "email#{n}@domain.com" }
    sequence(:preferred_name) {|n| "preferred_name#{n}" }
    birthdate { FFaker::Time.date }
  end
end
