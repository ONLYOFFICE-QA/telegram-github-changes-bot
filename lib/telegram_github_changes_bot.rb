# frozen_string_literal: true

require 'telegram/bot'
require_relative 'telegram_github_changes_bot/github_repo_changes'

# Main class for application
class TelegramGithubChangesBot
  # @return [String] help message
  def help_message
    "This bot is used to get changes between versions of DocumentServer\n"\
      "-------\n" \
      "Usage: <code>get_changes version1...version2</code>\n"\
      "version1, version2 in format like <code>v6.4.1.45</code>\n" \
      "-------\n" \
      "example: \n"\
      '/get_changes v6.5.0.46...v6.5.0.57'
  end
end
