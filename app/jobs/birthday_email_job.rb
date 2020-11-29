# frozen_string_literal: true

class BirthdayEmailJob < ApplicationJob
  def perform
    users = User.today_birthday_email_receivers

    users.find_each do |user|
      Users::BirthdayMailer.notify(user.id).deliver_later
    end
  end
end
