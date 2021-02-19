# frozen_string_literal: true

class BirthdayCampaignService
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def call
    CustomerCampaignMailer.with(user: @user, campaign: campaign)
      .birthday_email.deliver_later
  end

  private

  def campaign
    @campaign ||= Campaign.find_by(key: "birthday")
  end
end

