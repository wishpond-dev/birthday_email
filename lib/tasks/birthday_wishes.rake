namespace :birthday_wishes do
  desc "Send birthday wishes to users"
  task send_birthday_wishes: :environment do
    Consent.find_by(key: 'email').users.each do |user|
      BirthdayWishJob.perform_now(user) if user.birthdate.eql?(Date.today)
    end
  end

end
