class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.birthday_email.subject
  #
  def birthday_email
    @user = params[:user]

    I18n.with_locale(@user.locale) do
      mail(
        to: @user.email,
        subject: I18n.t('user_mailer.birthday_email.subject')
      )
    end
  end
end
