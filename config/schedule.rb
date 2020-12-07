# frozen_string_literal: true

every :day, at: pt('00:30am') do
  rake "sent_birthday_email"
end
