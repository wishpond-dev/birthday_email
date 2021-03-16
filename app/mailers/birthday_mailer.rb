# frozen_string_literal: true

class BirthdayMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.birthday_mailer.birthday_greeting.subject
  #
  def birthday_greeting(user)
    @user = user
    I18n.locale = user.locale || I18n.default_locale
    mail to: user.email, subject: I18n.t("birthday_mailer.birthday_greeting.subject")
  end
end
