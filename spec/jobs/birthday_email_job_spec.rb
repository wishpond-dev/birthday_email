# frozen_string_literal: true

require "rails_helper"

RSpec.describe BirthdayEmailJob, type: :job do
  describe "#perform" do
    let(:today) { Time.zone.today }

    let!(:user) { create :user, birthdate: 2.days.ago }
    let(:another_user) { create :user, birthdate: today, email: "another_email" }

    let(:user_consent) { create :user_consent, user: user, consented: true }
    let(:consent) { user_consent.consent }

    context "when two users born today and both consented" do
      before do
        create :user_consent, user: another_user, consent: consent, consented: true

        consent.update(key: "email")
        user.update(birthdate: today)
      end

      it "sends two emails" do
        expect { described_class.perform_now(today.yday) }
          .to change { ActionMailer::Base.deliveries.count }.by(2)
      end
    end

    context "when two users born today, but they did not consented to receive emails" do
      before do
        create :user_consent, user: another_user, consent: consent, consented: false

        consent.update(key: "email")
        user_consent.update(consented: false)

        user.update(birthdate: today)
      end

      it "sends two emails" do
        expect { described_class.perform_now(today.yday) }
          .to change { ActionMailer::Base.deliveries.count }.by(0)
      end
    end

    context "when two users born today, but only one consented to receive emails" do
      before do
        create :user_consent, user: another_user, consent: consent, consented: false

        consent.update(key: "email")
        user.update(birthdate: today)
      end

      it "sends two emails" do
        expect { described_class.perform_now(today.yday) }
          .to change { ActionMailer::Base.deliveries.count }.by(1)
      end
    end

    context "when no users born today" do
      it "does not send emails" do
        expect { described_class.perform_now(today.yday) }
          .to change { ActionMailer::Base.deliveries.count }.by(0)
      end
    end
  end
end
