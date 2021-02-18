# frozen_string_literal: true

require "rails_helper"

RSpec.describe BirthdayCampaignJob, type: :job do
  include ActiveJob::TestHelper

  subject(:job) { described_class.perform_later(uuid) }

  let(:user) { instance_double(User) }
  let(:uuid) { ":uuid" }
  let(:campaign) { instance_double(BirthdayCampaignService) }

  before do
    allow(User).to receive(:find_by).with(id: uuid).and_return(user)
    allow(BirthdayCampaignService)
      .to receive(:new).with(user).and_return(campaign)
  end

  it 'queues the job' do
    expect { job }
      .to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
  end

  it 'executes perform' do
    expect(campaign).to receive(:call)
    perform_enqueued_jobs { job }
  end

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end
end

