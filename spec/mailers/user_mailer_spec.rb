require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "birthday_email" do
    let(:user) { create(:user) }
    let(:user_pt) { create(:user, locale: 'pt') }

    context 'en' do
      let(:mail) { UserMailer.with(user: user).birthday_email }

      it "renders the headers" do
        expect(mail.subject).to eq("Happy birthday")
        expect(mail.to).to eq([user.email])
        expect(mail.from).to eq(["from@example.com"])
      end

      it "renders the body" do
        expect(mail.body.encoded).to match("change config/locales/en.yml to add a proper message.")
      end
    end

    context 'pt' do
      let(:mail) { UserMailer.with(user: user_pt).birthday_email }

      it "renders the headers" do
        expect(mail.subject).to eq("Feliz aniversario!")
        expect(mail.to).to eq([user_pt.email])
        expect(mail.from).to eq(["from@example.com"])
      end

      it "renders the body" do
        expect(mail.body.encoded).to match("altere config/locales/pt.yml para adicionar uma mensagem apropriada.")
      end
    end
  end

end
