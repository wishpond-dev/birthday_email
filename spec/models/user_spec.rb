# frozen_string_literal: true
# == Schema Information
#
# Table name: users
#
#  id                          :uuid             not null, primary key, indexed => [encrypted_email, encrypted_email_iv]
#  birthdate                   :date             not null
#  birthdate_md_format         :string(4)        not null
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

  it "birthdate_md_format is set" do
    data = create(:user)
    expect(data.birthdate_md_format).to eq data.birthdate.strftime('%m%d')
  end

  describe "#username_for_mail" do
    subject { user.username_for_mail }

    context 'preferred_name and username is not set' do
      let (:user) { build(:user, preferred_name: nil, username: nil) }

      it 'return default username' do
        is_expected.to eq 'Guest'
      end
      context 'locale other than en' do
        let (:user) { build(:user, preferred_name: nil, username: nil) }

        it 'return default username' do
          I18n.with_locale(:ja) do
            is_expected.to eq 'ゲスト'
          end
        end
      end
    end

    context 'username is set and preferred_name is not set' do
      let (:user) { build(:user, preferred_name: nil) }

      it 'return default username' do
        is_expected.to eq user.username
      end
    end

    context 'username is set and preferred_name is set' do
      let (:user) { build(:user) }

      it 'return default username' do
        is_expected.to eq user.preferred_name
      end
    end
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
end
