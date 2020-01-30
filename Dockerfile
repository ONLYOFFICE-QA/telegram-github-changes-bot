FROM ruby:2.7

LABEL maintainer="shockwavenn@gmail.com"

RUN gem install bundler
COPY . /root/telegram-github-changes-bot
WORKDIR /root/telegram-github-changes-bot
RUN bundle install --without development test
CMD ruby bot.rb
