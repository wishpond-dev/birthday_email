# frozen_string_literal: true

require "rails_helper"
require "rake"

describe "email" do
  before do
    WhoIsDoingCodeReview::Application.load_tasks if Rake::Task.tasks.empty?
  end

  describe "birthday_email" do
    subject(:task) { Rake::Task["email:birthday_email"] }

    let(:email_campaign) do
      instance_double("Email::Service::DispatchBirthdayCampaign").as_null_object
    end

    before do
      allow(Email::Service::DispatchBirthdayCampaign)
        .to receive(:new).and_return(email_campaign)

      task.invoke
    end

    it "dispath birthday campaign" do
      expect(email_campaign).to have_received(:dispatch!).once
    end
  end
end
