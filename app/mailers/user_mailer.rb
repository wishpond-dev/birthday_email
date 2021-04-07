class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.birthday_greeting.subject
  #
  def birthday_greeting user
    @user = user

    I18n.with_locale(@user.locale) do
      mail(
        to: @user.email,
        subject: I18n.t('user_mailer.subject.happy_birthday')
      )
    end
  end
end
