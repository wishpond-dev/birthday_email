# frozen_string_literal: true

# spec/mailers/user_mailer_spec.rb
require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "birthday_email" do
    let(:user) { create(:user) }
    let(:user_portuguese) { create(:user, locale: "pt-BR") }
    let(:mail) { described_class.with(user: user).birthday_email }
    let(:mail_portuguese) { described_class.with(user: user_portuguese).birthday_email }

    it "renders the headers" do
      expect(mail.subject).to eq(I18n.t("user_mailer.birthday_email.subject"))
      expect(mail.to).to eq([user.email])
    end

    context "when is english locale" do
      it "renders the body" do
        expect(mail.text_part.body.raw_source).to match("Happy Birthday #{user.username}\r\n")
      end
    end

    context "when is portuguese locale" do
      it "renders the body" do
        expect(mail_portuguese.text_part.body.raw_source)
          .to match("Parabéns #{user_portuguese.username}\r\n")
      end
    end
  end
end
