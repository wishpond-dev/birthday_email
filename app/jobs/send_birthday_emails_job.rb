# frozen_string_literal: true

require "sendgrid-ruby"

class SendBirthdayEmailsJob < ApplicationJob
  include SendGrid

  queue_as :default

  def perform(*)
    # get users who's birthday is today
    users = User.consented_to(Consent.find_by(key: "email")).has_birthday_today

    users.find_each(batch_size: 100) do |user|
      UserMailer.send_birthday_email(user).deliver
    end
  end
end
