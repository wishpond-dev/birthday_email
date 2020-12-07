# frozen_string_literal: true

if Rails.env.production?
  task :sent_birthday_email do
    birthday_boys_ids = User.where(
      'EXTRACT(month FROM birthdate) = ? AND EXTRACT(day FROM birthdate) = ?',
      Date.current.month, Date.current.day
    )
    .select(:id)
    birthday_boys_ids.each do |user_id|
      SendBirthdayEmailWorker.perform_later(user_id)
    end
  end
end
