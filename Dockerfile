FROM ruby:2.5

LABEL maintainer="shockwavenn@gmail.com"

COPY . /root/telegram-github-changes-bot
WORKDIR /root/telegram-github-changes-bot
RUN bundle install --without development test
CMD ruby bot.rb
