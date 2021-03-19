class InformUser
    def send_email
        puts 'job starting...'
        Consent.find_by(key: 'email').find_in_batches do |group|
            sleep(50) # Make sure it doesn't get too crowded in there!
            users = group.users
            users.each do |user| 
                I18n.default_locale = user.locale if user.locale.present?
                if user.birthday.to_date == Date.today # find today is birthday
                    UserMailer.with(user: user).birthday_wish.deliver_now  
                end
            end
        end 
        puts 'job ends...'   
    end
end
