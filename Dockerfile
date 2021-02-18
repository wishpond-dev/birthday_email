FROM ruby:2.5.1-alpine

RUN apk update && apk add --no-cache linux-headers build-base nodejs yarn
RUN apk add --no-cache libxml2-dev libxslt-dev git tzdata curl make gcc libsodium
RUN apk add --no-cache libpq postgresql-dev

RUN bundle config build.nokogiri --use-system-libraries

ENV APP_HOME /birthday_email/
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

COPY Gemfile Gemfile.lock $APP_HOME

RUN gem install bundler && bundle install --jobs 20 --retry 5

COPY . $APP_HOME

EXPOSE 80

CMD [ "bundle", "exec", "puma", "-C", "config/puma.rb" ]

