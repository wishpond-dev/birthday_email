# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def sample_birthday_email
    user = User.last || User.new(preferred_name: "TestName", email: "test_name@email", locale: "de")
    UserMailer.birthday_email(user)
  end
end
