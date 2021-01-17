# frozen_string_literal: true

require "rails_helper"

RSpec.describe SendBirthdayEmailsJob, type: :job do
  describe "#perform_later" do
    it "sends emails to users" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        SendBirthdayEmailsJob.set(queue: "low").perform_later("birthday_email")
      }.to have_enqueued_job.with("birthday_email").on_queue("low").at(:no_wait)
    end
  end
end
