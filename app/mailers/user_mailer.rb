class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.birthday_email.subject
  #
  def birthday_email
    @greeting = "Hi"
    @email = params[:email]

    mail to: @email
  end
end
