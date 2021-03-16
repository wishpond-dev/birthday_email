# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/birthday_mailer
class BirthdayMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/birthday_mailer/birthday_greeting
  def birthday_greeting
    BirthdayMailerMailer.birthday_greeting
  end
end
