# frozen_string_literal: true

class BirthdayCampaignJob < ApplicationJob
  discard_on ActiveRecord::RecordNotFound

  def perform(user_id)
    user = User.find(user_id)
    BirthdayCampaignService.new(user).call
  end
end

