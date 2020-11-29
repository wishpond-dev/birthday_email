# frozen_string_literal: true

class ApplicationJob < ApplicationJob
  def perform

    user_ids = User.consented_to(Consent.find_by(key: 'email'))
      .where(birthday: Time.zone.now).pluck(:id)

    user_ids.find_each do |user_id|
      Users::BirthdayMailer.notify(user_id).deliver_later
    end
  end
end
