# frozen_string_literal: true

namespace :email do
  desc "Send birthday emails to users"
  task birthday_email: :environment do
    birthday_campaign = Email::Service::DispatchBirthdayCampaign.new
    birthday_campaign.dispatch!
  end
end
