# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/birthday_greeting
  def birthday_greeting
    UserMailerMailer.birthday_greeting
  end

end
