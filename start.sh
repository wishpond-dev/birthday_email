bundle install --quiet

if [ "$SERVICE_TYPE" = "worker" ]; then
  [[ "$RAILS_ENV" = "" ]] && CURRENT_ENV="development" || CURRENT_ENV="$RAILS_ENV"
  bundle exec sidekiq -C config/sidekiq.yml
  bundle exec whenever --update-crontab --set environment=$CURRENT_ENV
  crond start
else
  rm -f tmp/pids/server.pid
  rails s -b 0.0.0.0 -p 3000
fi