# frozen_string_literal: true
# frozen_string_literal: true

class BirthdayMailer < ApplicationMailer
  layout false

  def birthday_mail(user)
    mail from: 'robot@noreply.com',
         to: user.encrypted_email,
         subject: "Happy birthday, #{user.encrypted_username}!"
  end
end
