require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "birthday_email" do
    let(:user) { create :user, preferred_name: "TestName", email: "test_name@email.com" }
    let(:mail) { described_class.birthday_email(user).deliver_now }

    it "renders the receiver email" do
      expect(mail.to).to eq([user.email])
    end

    it "renders the sender email" do
      expect(mail.from).to eq(["no-reply@wishpond.com"])
    end

    it "uses correct user preferred_name" do
      expect(mail.body.encoded).to match(user.preferred_name)
    end

    context "with default locale" do
      it "renders the subject" do
        expect(mail.subject).to eq("Happy Birthday example subject")
      end
    end

    context "without default locale" do
      before do
        user.update_column(:locale, "pt")
      end

      it "renders the subject" do
        expect(mail.subject).to eq("Exemplo de assunto de email de aniversário")
      end
    end
  end
end
