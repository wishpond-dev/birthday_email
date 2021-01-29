#!/bin/bash
set -e

bundle install
bundle exec rails db:create db:migrate db:seed
rm -rf tmp/pids/server.pid

exec "$@"