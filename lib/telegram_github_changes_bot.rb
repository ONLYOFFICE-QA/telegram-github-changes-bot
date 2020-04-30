# frozen_string_literal: true

require 'telegram/bot'
require_relative 'telegram_github_changes_bot/github_repo_changes'

# @param message [String] message to send
# @return [String] sanitized message according to telegram rules
def sanitize_message(message)
  message.gsub('_', '\\_')
end
