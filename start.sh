bundle install --quiet
[[ "$RAILS_ENV" = "" ]] && CURRENT_ENV="development" || CURRENT_ENV="$RAILS_ENV"
bundle exec whenever --update-crontab --set environment=$CURRENT_ENV
crond start
rm -f tmp/pids/server.pid
rails s -b 0.0.0.0 -p 3000