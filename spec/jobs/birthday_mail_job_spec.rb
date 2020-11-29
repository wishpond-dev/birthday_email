require 'rails_helper'

RSpec.describe BirthdayEmailJob, type: :job do
  include ActiveJob::TestHelper

  describe '.perform' do
    let(:mailer_mock) { double('mailer mock') }
    let!(:today) { Time.zone.today }
    let(:email_consent) { build(:consent, :email) }

    let!(:consented) { create_list(:user_consent, 10, :consented, consent: email_consent) }
    let!(:consented_expired) { create_list(:user_consent, 3, :consented, :expired, consent: email_consent) }
    let!(:not_consented) { create_list(:user_consent, 3, consent: email_consent) }
    let!(:consented_about_others) { create_list(:user_consent, 3, :consented) }

    before do
      allow(mailer_mock).to receive(:deliver_later).and_return nil
      allow(Users::BirthdayMailer).to receive(:notify).and_return(mailer_mock)

      # today birthday email receivers
      consented.slice(0, 3).each do |user_consent|
        user = user_consent.user
        user.birthdate = Time.zone.local(user.birthdate.year, today.month, today.day)
        user.save!
      end

      # yesterday birthday email receivers
      consented.slice(4, 7).each do |user_consent|
        user = user_consent.user
        user.birthdate = Time.zone.local(user.birthdate.year, today.month, (today - 1.day).day)
        user.save!
      end

      # tomorrow birthday email receivers
      consented.slice(7, 10).each do |user_consent|
        user = user_consent.user
        user.birthdate = Time.zone.local(user.birthdate.year, today.month, (today + 1.day).day)
        user.save!
      end

      # today birthday but not consented receivers
      (consented_expired + not_consented + consented_about_others).each do |record|
        user = record.user
        user.birthdate = Time.zone.local(user.birthdate.year, today.month, today.day)
        user.save!
      end

    end

    subject { described_class.perform_now }

    it do
      subject
      expect(mailer_mock).to have_received(:deliver_later).exactly(3).times
    end
  end
end
