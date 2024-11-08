# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  enable_coverage :branch
end

require 'telegram_github_changes_bot'
require 'vcr'

# @return [TelegramGithubChangesBot] default changes bot for rspec
def changes_bot
  @changes_bot ||= TelegramGithubChangesBot.new
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock
  config.filter_sensitive_data('<GITHUB_USER>') { changes_bot.config[:github_user] }
  config.filter_sensitive_data('<GITHUB_PASSWORD>') { changes_bot.config[:github_user_password] }
  config.filter_sensitive_data('<AUTHORIZATION>') do |interaction|
    interaction.request.headers['Authorization']&.first
  end
  config.configure_rspec_metadata!
end
