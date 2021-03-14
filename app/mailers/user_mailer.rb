# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: "no-reply@wishpond.com"

  def birthday_email(user)
    @user = user
    locale = user.locale || I18n.default_locale
    I18n.with_locale(locale) do
      mail(to: @user.email)
    end
  end
end
