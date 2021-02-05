#syntax = docker/dockerfile:experimental

FROM ruby:2.7.2-alpine as builder

RUN apk --update add --virtual build-dependencies build-base \
    curl-dev mysql-dev linux-headers

RUN gem install bundler

WORKDIR /tmp
COPY Gemfile .
COPY Gemfile.lock .

RUN bundle install --jobs=4

RUN apk del build-dependencies


FROM ruby:2.7.2-alpine

RUN apk --update add bash nodejs mariadb-dev tzdata

RUN gem install bundler

ENV APP_DIR /app
RUN mkdir -p $APP_DIR
WORKDIR $APP_DIR
COPY . $APP_DIR

COPY --from=builder /usr/local/bundle /usr/local/bundle