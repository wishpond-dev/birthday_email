namespace :email_users do
  desc "Send email to all users on bday that consent to receive those emails"
  task birthday_email: :environment do
    EmailUsersOnBirthday.call
  end

end
