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

# rubocob:disable Layout/LineLength

class User < ApplicationRecord
  include Encryptable
  attr_encrypted :email, :preferred_name, :username, default_crypto_options
  blind_index :email, key: blind_index_key, expression: ->(v) { v.downcase }

  before_create :set_uuid
  before_create :create_encryption_key
  after_create :save_encryption_key
  after_destroy :delete_encryption_key

  has_many :user_consents, -> { consented.up_to_date }, inverse_of: :user, dependent: :destroy
  has_many :consents, through: :user_consents, inverse_of: :users

  validates :email, uniqueness: {case_sensitive: false}
  before_validation :monkeypatch_email_bidx

  scope :consented_to, ->(c) { joins(:user_consents).where(user_consents: {consent: c}) }
  scope :born_in, lambda {|day, month|
                    where("EXTRACT('day' FROM birthdate) || '-' || EXTRACT('month' FROM birthdate) = ?",
                          "#{day}-#{month}")
                  }

  scope :consented_email_and_birthday_in, lambda {|day, month|
                                            born_in(day, month).consented_to(Consent.find_by(key: "email"))
                                          }

  # Required because the blind_index doesn't seem to like the email column
  def monkeypatch_email_bidx
    compute_email_bidx
  end

  # entry point for exporting user's personal information
  def export_personal_information
    return unless persisted?

    descendants = ApplicationRecord.descendants.select(&:has_personal_information?)
    {}.tap do |result|
      descendants.each do |descendant|
        result[descendant.name] = descendant.export_personal_information(id)
      end
    end.to_json
  end

  # simplest example
  def self.export_personal_information(user_id)
    User.find(user_id).as_json(only: personal_information)
  end

  def self.personal_information
    %i[id short_id username preferred_name email updated_at created_at]
  end

  # Can't just `pluck` like normal, since email is a virtual attribute
  def self.emails
    select(:id, :encrypted_email, :encrypted_email_iv).map(&:email)
  end

  def consented_to?(key)
    consents.find_by(key: key)
  end

  def display_name
    preferred_name || username
  end

  def valid_location
    I18n.available_locales.include?(locale.to_sym) ? locale.to_sym : I18n.default_locale
  end

  private

  def set_uuid
    self.uuid ||= SecureRandom.uuid
  end
end
