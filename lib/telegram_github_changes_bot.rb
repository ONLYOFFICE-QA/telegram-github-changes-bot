# frozen_string_literal: true

require 'telegram/bot'
require_relative 'telegram_github_changes_bot/github_repo_changes'

# Main class for application
class TelegramGithubChangesBot
  # Log that some message is received by bot
  # @return [void]
  def log_message_receive(message)
    logger.info("Got message `#{message.text}` from user: `@#{message.from.username}`")
  end

  # Log that some message is received by bot
  # @return [void]
  def log_unknown_command(message)
    logger.info("Command `#{message.text}` is unsupported. Ignoring it")
  end

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

  private

  # @return [Logger] logger interface
  def logger
    @logger ||= Logger.new($stdout)
  end
end
