class UserMailer < ApplicationMailer
  def birthdate_email(user_id)
    @user = User.find(user_id)

    I18n.locale = @user.locale

    mail(to: @user.email, subject: t(".subject_mail") )
  end
end
