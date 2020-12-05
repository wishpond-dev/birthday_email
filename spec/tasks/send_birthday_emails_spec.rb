# frozen_string_literal: true

# in spec/tasks/send_birthday_emails_spec.rb
require "rails_helper"

Rails.application.load_tasks

describe "send_birthday_emails:run" do
  context 'when does it have emails to send' do
    let!(:user) { create(:user, birthdate: Time.zone.now) }
    let!(:consent) { create(:consent, key: "email", users: [user]) }

    it "expected to fetch the birthdays of today and send email to them" do
      expect { run_task(task_name: "send_birthday_emails:run") }.to have_enqueued_job
        .on_queue("mailers")
        .with("UserMailer", "birthday_email", "deliver_now", user: user)
    end
  end

  context 'when does not have emails to send' do
    let!(:user) { create(:user, birthdate: Time.zone.now + 1.day) }
    let!(:consent) { create(:consent, key: "email", users: [user]) }

    it "expected to not send any emails" do
      expect { run_task(task_name: "send_birthday_emails:run") }.not_to have_enqueued_job
        .on_queue("mailers")
    end
  end
end

def run_task(task_name:)
  Rake::Task[task_name].invoke
end
