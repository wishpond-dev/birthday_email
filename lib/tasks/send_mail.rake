# frozen_string_literal: true

namespace :send_mail do
  desc "Send mail to users to wish them on their birthday"

  task :birthday_wish => [ :environment ] do
    User.consented_to(Consent.find_by(key: "email")).each do |user|
      UserMailer.with(user: user).birthday_wish.deliver_now! if user.users_birthday?
      puts "mail sent to #{user.preferred_name}" if user.users_birthday?
    end
  end
end
