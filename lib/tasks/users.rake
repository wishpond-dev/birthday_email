namespace :users do
  desc "Send birthday email"
  task birthday_email: :environment do
    SendBirthdayEmailsJob.perform_later
  end

end
