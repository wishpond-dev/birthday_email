# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "birthday email" do
    let(:user) {
      User.new(preferred_name: "Test User", email: "rptasznik+testuser@gmail.com",
               username: "testuser", locale: :en, birthdate: Time.zone.today)
    }
    let(:mail) { UserMailer.send_birthday_email(user) }

    it "renders the headers" do
      expect(mail.subject).to eq(I18n.t(:subject, scope: %i[emails birthday_email], locale: user.locale))
      expect(mail.to).to eq(["rptasznik+testuser@gmail.com"])
      expect(mail.from).to eq([BIRTHDAY_ANNOUNCEMENT_EMAIL_FROM])
    end

    it "renders the body" do
      expect(mail.body.encoded).to include(I18n.t(:message, scope: %i[emails birthday_email], locale: user.locale))
    end
  end
end
