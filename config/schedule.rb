set :output, "log/cron.log"

every 1.day, at: "12:00 AM" do
  rake "send_mail:birthday_wish"
end
