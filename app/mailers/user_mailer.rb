class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.birthday_greeting.subject
  #
  def birthday_greeting
    @user = User.new username: 'Nosfheratu', email: 'fher@mail.me'

    mail to: @user.email
  end
end
