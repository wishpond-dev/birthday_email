set :output, 'log/cron.log'

every 1.day do
  rake "send_birthday_emails:run"
end