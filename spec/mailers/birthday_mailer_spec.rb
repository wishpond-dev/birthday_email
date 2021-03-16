# frozen_string_literal: true

require "rails_helper"

RSpec.describe BirthdayMailer, type: :mailer do
  describe "birthday_greeting" do
    let(:user) { build :user }
    let(:mail) { BirthdayMailer.birthday_greeting(user) }

    before { I18n.locale = user.locale || I18n.default_locale }

    it "renders the headers" do
      expect(mail.subject).to eq(I18n.t("birthday_mailer.birthday_greeting.subject"))
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      # expect(mail.body.encoded).to match("Hi")
      skip
    end
  end
end
