require 'rails_helper'

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EmailUsersOnBirthday do
  context 'users with consent' do
    let!(:consent) { create :consent, key: 'email' }
    let!(:user) { FactoryBot.create(:user, birthdate: 1.day.ago) }
    let!(:bday_user) { FactoryBot.create(:user, birthdate: Date.today) }
    let!(:bday_user2) { FactoryBot.create(:user, birthdate: Date.today) }
    let!(:user_consent) { create :user_consent, :consented, user: user, consent: consent }
    let!(:user_not_consent_bday) { create :user_consent, user: bday_user2 }

    context 'on birthday' do
      let!(:user_consent_bday) { create :user_consent, :consented, user: bday_user, consent: consent }
      it 'send email to users that accept receiving emails' do
        expect {
          EmailUsersOnBirthday.call
        }.to have_enqueued_job.on_queue('mailers')
      end
    end
  end

  context 'users without consent' do
    it 'send email to users that accept receiving emails' do
      expect {
        EmailUsersOnBirthday.call
      }.to_not have_enqueued_job.on_queue('mailers')
    end
  end
end
