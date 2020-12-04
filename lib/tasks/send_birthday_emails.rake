# frozen_string_literal: true

namespace :send_birthday_emails do
  desc "Send birthday emails based on the current day, only to the users who consented"

  task run: :environment do
    User.todays_birthdays_with_consent.each_slice(100) do |batch|
      batch.each do |user|
        UserMailer.with(user: user).birthday_email.deliver_later
      end
    end
  end
end
