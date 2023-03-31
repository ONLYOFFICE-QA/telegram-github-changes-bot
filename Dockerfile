FROM ruby:3.2.2-alpine

LABEL maintainer="shockwavenn@gmail.com"

RUN gem update bundler
COPY . /root/telegram-github-changes-bot
WORKDIR /root/telegram-github-changes-bot
RUN bundle config set without 'development test' && \
    bundle install
CMD ["ruby", "bot.rb"]
