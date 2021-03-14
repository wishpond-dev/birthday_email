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
#  index_user_on_bithdate_day_of_year   (date_part('doy'::text, birthdate))
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

  describe "born_in" do
    let(:born_in) { 1.day.ago }

    context "when user born in the queried day" do
      let(:user) { create :user, birthdate: born_in }

      it { expect(described_class.born_in(born_in.yday)).to eq [user] }
    end

    context "when no user born in the queried day" do
      before { create :user, birthdate: Time.zone.today }

      it { expect(described_class.born_in(born_in.yday)).to be_empty }
    end
  end

  describe "email_username" do
    context "when user has preferred_name" do
      let(:preferred_name) { "preferred_name" }

      before { user.update(preferred_name: preferred_name) }

      it { expect(user.email_username).to eq(preferred_name) }
    end

    context "when user doesn't have preferred_name" do
      let(:username) { "username" }

      before { user.update(preferred_name: nil, username: username) }

      it { expect(user.email_username).to eq(username) }
    end
  end
end
