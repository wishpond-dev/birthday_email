class EmailUsersOnBirthday
  def call
    User.consented_and_on_bday.in_batches do |users|
      users.each do |user|
        UserMailer.with(user: user).birthday_email.deliver_later
      end
    end
  end

  def self.call
    self.new.call()
  end
end