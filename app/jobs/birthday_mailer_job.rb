# frozen_string_literal: true

class BirthdayMailerJob < ApplicationJob
  queue_as :default

  def perform
    now = Time.zone.now
    Consent.find_by(key: "email").users.birthday_on(now).each do |user|
      BirthdayMailer.birthday_greeting(user).deliver_later
    end
  end
end
