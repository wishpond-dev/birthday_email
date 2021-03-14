require "rails_helper"

RSpec.describe BirthdayEmailJob, type: :job do
  describe "#perform" do
    let(:today) { Date.today }
    let!(:user) { create :user, birthdate: 2.days.ago }

    context "has two users which born today" do
      let(:user_consent) { create :user_consent, user: user, consented: true }
      let(:consent) { user_consent.consent }

      let(:another_user) { create :user, birthdate: today, email: "another_email" }

      context "and both consented to receive emails" do
        let!(:another_user_consent) { create :user_consent, user: another_user, consent: consent, consented: true }

        before do
          consent.update_column(:key, "email")
          user.update_column(:birthdate, today)
        end

        it "sends two emails" do
          expect { BirthdayEmailJob.perform_now(today.yday) }
            .to change { ActionMailer::Base.deliveries.count }.by(2)
        end
      end

      context "and both did not consented to receive emails" do
        let!(:another_user_consent) { create :user_consent, user: another_user, consent: consent, consented: false }

        before do
          consent.update_column(:key, "email")
          user_consent.update_column(:consented, false)

          user.update_column(:birthdate, today)
        end

        it "sends two emails" do
          expect { BirthdayEmailJob.perform_now(today.yday) }
            .to change { ActionMailer::Base.deliveries.count }.by(0)
        end
      end

      context "and one did not consented to receive emails" do
        let!(:another_user_consent) { create :user_consent, user: another_user, consent: consent, consented: false }

        before do
          consent.update_column(:key, "email")
          user.update_column(:birthdate, today)
        end

        it "sends two emails" do
          expect { BirthdayEmailJob.perform_now(today.yday) }
            .to change { ActionMailer::Base.deliveries.count }.by(1)
        end
      end
    end

    context "doesn't have users which born today" do
      it "does not send emails" do
        expect { BirthdayEmailJob.perform_now(today.yday) }
          .to change { ActionMailer::Base.deliveries.count }.by(0)
      end
    end
  end
end
