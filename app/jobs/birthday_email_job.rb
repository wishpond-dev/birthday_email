class BirthdayEmailJob < ApplicationJob
  queue_as :mailers

  def perform
    #users = User.consented_to(Consent.find_by(key: "email")).today_birthday
    
    #users.each do |user| 
     # SendBirthdayEmailJob.perform_later(user.id)
    #end
    puts "dfasdfasdfasdfadsf asdfasdfadsf"
  end
end
