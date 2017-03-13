FROM ruby:2.4

MAINTAINER Pavel.Lobashov "shockwavenn@gmail.com"

COPY . /root/telegram-github-changes-bot
WORKDIR /root/telegram-github-changes-bot
RUN bundle install
CMD ruby bot.rb > bot.log