class SendBirthdayEmailJob < ApplicationJob
  queue_as :mailers

  def perform(user_id)
    UserMailer.birthdate_email(user_id).deliver_now
  end
end
