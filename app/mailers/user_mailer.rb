class UserMailer < ApplicationMailer
  default from: 'noreply@waterpound.com'

  def birthday_wish
    @user = params[:user]
    @url  = 'http://example.com/login'
    I18n.with_locale(locale) do
      mail(to: @user.email, subject: t('mail.subject'))
    end
  end

  private

  def locale
    @user.locale.to_sym || I18n.locale
  end
end
