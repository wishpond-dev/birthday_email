# frozen_string_literal: true

class BirthdayCampaignJob < ApplicationJob
  def perform(user_id)
    user = User.find(user_id)
    BirthdayCampaignService.new(user).call
  end
end

