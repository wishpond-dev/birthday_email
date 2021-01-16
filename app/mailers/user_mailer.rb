# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: BIRTHDAY_ANNOUNCEMENT_EMAIL_FROM

  def send_birthday_email(user)
    @user = user
    @message = I18n.t(:message, scope: %i[emails birthday_email], locale: user.locale)

    mail(to: @user.email, subject: I18n.t(:subject, scope: %i[emails birthday_email], locale: user.locale))
  end
end
