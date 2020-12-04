FROM ruby:2.5.1-alpine

RUN mkdir /app

WORKDIR /app

COPY . /app

RUN apk update && apk add --no-cache openssh git make build-base less bash libsodium

RUN apk add postgresql-dev postgresql

RUN bundle install

RUN chmod +x ./start.sh

CMD sh /app/start.sh

EXPOSE 3012
