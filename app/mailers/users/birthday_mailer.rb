class Users::BirthdayMailer < ApplicationMailer

  def notify(user)
    @user = user

    mail(to: user.email, subject: 'test')
  end
end
