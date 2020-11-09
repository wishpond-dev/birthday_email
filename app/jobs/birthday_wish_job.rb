class BirthdayWishJob < ApplicationJob
  queue_as :default

  def perform(user)
    BirthdayWishMailer.send_birthday_wish(user).deliver
  end
end
