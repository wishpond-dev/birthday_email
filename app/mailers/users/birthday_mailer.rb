class Users::BirthdayMailer < ApplicationMailer
  def notify(user_id)
    @user = User.find(user_id)
    I18n.with_locale(@user.locale) do
      mail(to: @user.email, subject: default_i18n_subject(username: @user.username_for_mail)) do |format|
        format.text { render template_name(__method__) }
        format.html { render template_name(__method__) }
      end
    end
  end

  private

  def template_name(key)
    "users/birthday_mailer/#{I18n.locale}/#{key}"
  end
end
