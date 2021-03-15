# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: "no-reply@wishpond.com"

  def birthday_email(user)
    @user = user
    I18n.with_locale(@user.valid_location) do
      mail(to: @user.email)
    end
  end
end
