class BirthdayWishMailer < ActionMailer::Base

  def send_birthday_wish(recipient)
    @recipient = recipient

    I18n.with_locale(recipient.locale) do
      mail(
        to: @recipient.email,
        subject: I18n.t('birthday_wish_mailer.send_birthday_wish.subject')
      )
    end
  end

end
