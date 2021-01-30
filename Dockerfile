FROM ruby:2.5.1

ENV BUNDLE_PATH=/bundle/vendor

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3B4FE6ACC0B21F32 && \
  echo "deb http://archive.ubuntu.com/ubuntu/ focal main restricted universe multiverse" > /etc/apt/sources.list && \
  apt-get update -qq \
    && apt-get install -y \
        build-essential \
        liblzma-dev \
        libnss3 \
        libpq-dev \
        libsodium23 \
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
