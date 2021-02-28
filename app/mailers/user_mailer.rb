# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: "noreply@wishpond.com"

  def birthday_wish
    @user = params[:user]
    I18n.with_locale(locale) do
      mail(to: @user.email, subject: t("mail.subject"))
    end
  end

  private

  def locale
    @user.locale.to_sym || I18n.locale
  end
end
