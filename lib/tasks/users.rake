namespace :users do
  namespace :notifications do
    desc 'Send greetings to users celebrating their birthdays'
    task send_birthday_greetings: :environment do
      User.consented_to(Consent.find_by(key: 'email')).birthday_today.each do |user|
        user.send_birthday_wishes
        print '.'
      end
      puts ''
      puts 'done!'
    end
  end
end
