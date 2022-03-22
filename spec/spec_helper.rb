# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  enable_coverage :branch
end

require 'telegram_github_changes_bot'

# @return [TelegramGithubChangesBot] default changes bot for rspec
def changes_bot
  @changes_bot ||= TelegramGithubChangesBot.new
end
