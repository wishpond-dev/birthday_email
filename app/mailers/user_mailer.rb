# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def birthday_email
    @user = params[:user]

    I18n.with_locale(@user.locale) do
      mail(
        to:      @user.email,
        subject: I18n.t("user_mailer.birthday_email.subject")
      )
    end
  end
end
