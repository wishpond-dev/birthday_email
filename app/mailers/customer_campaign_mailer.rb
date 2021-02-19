# frozen_string_literal: true

class CustomerCampaignMailer < ApplicationMailer
  default from: ENV.fetch('GMAIL_USERNAME')

  def birthday_email
    @user = params[:user]
    @campaign = params[:campaign]

    I18n.with_locale(@user.locale) do
      mail(to: @user.email, subject: @campaign.subject)
    end
  end
end

