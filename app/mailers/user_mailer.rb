class UserMailer < ApplicationMailer
    def birthday_wish
        @user = params[:user]
        mail(to: @user.email, subject: 'Birthday wish')
    end
end
