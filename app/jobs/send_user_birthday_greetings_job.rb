class SendUserBirthdayGreetingsJob < ApplicationJob
  queue_as :user_birthday_wishes

  def perform(user_id)
    user = User.find(user_id)

    UserMailer.birthday_greeting(user).deliver_now
  end
end
