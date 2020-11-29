require "rails_helper"

RSpec.describe Users::BirthdayMailer, type: :mailer do

  describe '#notify' do
    let(:locale) { :en }
    let(:user) { create(:user, locale: locale) }
    subject { described_class.notify(user.id) }

    it do
      expect(subject.subject).to eq("Happy Birthday, #{user.preferred_name}")
      expect(subject.to).to match([user.email])
    end

    context 'locale other than en' do
      context 'locale is ja' do
        let(:locale) { :ja }
        it do
          expect(subject.subject).to eq("#{user.preferred_name}さん、誕生日おめでとう!")
          expect(subject.to).to match([user.email])
        end
      end

      context 'locale is fr' do
        let(:locale) { :fr }
        it do
          expect(subject.subject).to eq("Joyeux anniversaire, #{user.preferred_name}!")
          expect(subject.to).to match([user.email])
        end
      end
    end
  end
end
