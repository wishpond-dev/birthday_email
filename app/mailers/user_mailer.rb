class UserMailer < ApplicationMailer
    def birthday_wish
        @user = params[:user]
        mail(to: @user.email, subject: default_i18n_subject(user: @user.name))
    end
end
