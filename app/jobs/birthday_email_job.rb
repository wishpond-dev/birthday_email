class BirthdayEmailJob < ApplicationJob
  queue_as :default

  def perform(day_of_year)
    User.born_in(day_of_year).consented_to(Consent.find_by(key: 'email')).each do |user|
      UserMailer.birthday_email(user).deliver_now
    end
  end
end
