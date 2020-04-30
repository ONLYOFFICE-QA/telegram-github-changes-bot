# frozen_string_literal: true

# Class for helper methods to telegram
class TelegramHelper
  # @param message [String] message to send
  # @return [String] sanitized message according to telegram rules
  def self.sanitize_message(message)
    message.gsub('_', '\\_')
  end
end
