FROM ruby:2.5.1

ENV BUNDLE_PATH=/bundle/vendor

RUN apt-get update -qq \
    && apt-get install -y \
        build-essential \
        liblzma-dev \
        libnss3 \
        libpq-dev \
        libsodium-dev \
        postgresql-client \
        unzip \
        xvfb \
        zlib1g-dev

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock /app/

RUN gem install bundler foreman mailcatcher &&\
    bundle install

VOLUME /bundle

COPY . /app

EXPOSE 3000
EXPOSE 1080

ENTRYPOINT ["docker-entrypoint.sh"]

CMD foreman start -f Procfile.dev
