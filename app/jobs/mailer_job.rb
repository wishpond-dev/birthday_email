# frozen_string_literal: true

class MailerJob < ApplicationJob
  queue_as :default

  def perform
    consent_user_with_email_subscription = User.consented_to(Consent.find_by(key: "email"))

    consent_user_with_email_subscription.each do |user|
      UserMailer.with(user: user).birthday_wish.deliver_now! if user.users_birthday?
    end
  end
end
