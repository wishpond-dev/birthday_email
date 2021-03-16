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

require "rails_helper"

RSpec.describe User, type: :model do
  subject(:user) { create :user }

  it_behaves_like "an encryptable object", %i[email preferred_name username]

  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

  it "exports data in a GDPR-compliant way" do
    expect(create(:user).export_personal_information).to be_json
  end

  describe "consented_to?" do
    let(:key) { user_consent.consent.key }

    context "when the user has consented" do
      let(:user_consent) { create :user_consent, :consented, user: user }

      it { expect(user).to be_consented_to(key) }
    end

    context "when the user has not consented" do
      let(:user_consent) { create :user_consent, user: user }

      it { expect(user).not_to be_consented_to(key) }
    end
  end

  describe "birthday scope" do
    let(:now) { Time.zone.now }
    let(:birthday_users) { create_list(:birthday_user, 2) }
    let(:no_birthday_users) { create_list(:no_birthday_user, 3) }

    it "total birthday users" do
      expect(birthday_users.size).to eq(2)
      expect(User.birthday_on(now).size).to eq(2)
    end
    it "total no birthday users" do
      expect(no_birthday_users.size).to eq(3)
      expect(User.all.size - User.birthday_on(now).size).to eq(3)
    end
    it "total users" do
      expect(birthday_users.size + no_birthday_users.size).to eq(5)
      expect(User.all.size).to eq(5)
    end
  end
end
