# frozen_string_literal: true

class SendBirthdayEmailWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'default'

  def perform(user_id)
    user = User.find(user_id)
    return unless user.consented_to?(Consent.find_by(key: 'email'))

    BirthdayMailer.birthday_mail(user).deliver_later
  end
end
