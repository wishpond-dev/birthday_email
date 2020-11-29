# frozen_string_literal: true

class ApplicationJob < ApplicationJob
  def perform
    user_ids = User.today_birthday_message_receivers.pluck(:id)

    user_ids.find_each do |user_id|
      Users::BirthdayMailer.notify(user_id).deliver_later
    end
  end
end
