# frozen_string_literal: true

class ApplicationJob < ApplicationJob
  def perform

    targets = User.consented_to(Consent.find_by(key: 'email'))
      .where(birthday: Time.zone.now)

    targets.find_each do |target|
      UserBirthdayMailer.notify(target).deliver_later
    end
  end
end
