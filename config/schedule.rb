set :output, "log/cron.log"

every 1.day, at: "12:00 AM" do
  runner "MailerJob.perform_later"
end
