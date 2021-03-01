# frozen_string_literal: true.

require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "send user mail; locale => default" do
    let(:user) { create :user }
    let(:mail) { UserMailer.with(user: user).birthday_wish.deliver_now! }

    it "renders the subject in default locale i.e English" do
      expect(mail.subject).to eq("Happy Birthday")
    end

    it "renders the receiver email" do
      expect(mail.to).to eq([user.email])
    end

    it "renders the sender email" do
      expect(mail.from).to eq(["noreply@wishpond.com"])
    end
  end

  describe "send user mail; locale => fr" do
    let(:user1) { create :user, locale: :fr }
    let(:mail) { UserMailer.with(user: user1).birthday_wish.deliver_now! }

    it "renders the subject in french" do
      expect(mail.subject).to eq("joyeux anniversaire")
    end
  end
end
