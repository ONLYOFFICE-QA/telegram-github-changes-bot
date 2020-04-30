FROM ruby:2.7-alpine

LABEL maintainer="shockwavenn@gmail.com"

RUN gem install bundler
COPY . /root/telegram-github-changes-bot
WORKDIR /root/telegram-github-changes-bot
RUN bundle config set without 'development test'
RUN bundle install
CMD ruby bot.rb
