# frozen_string_literal: true

require "rails_helper"

RSpec.describe BirthdayMailerJob, type: :job do
  it "queues the job" do
    expect {
      described_class.perform_later
    }.to have_enqueued_job(described_class)
  end
end
