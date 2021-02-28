# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:

 env :PATH, ENV['PATH']
 set :output, "/log/cron.log"

 every 1.day, at: '08:00 am' do
  runner "BirthdayEmailJob.perform_later"
 end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
