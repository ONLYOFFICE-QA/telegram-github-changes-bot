# frozen_string_literal: true

require_relative 'lib/telegram_github_changes_bot'
changes_bot = TelegramGithubChangesBot.new

Telegram::Bot::Client.run(changes_bot.config[:telegram_bot_token]) do |bot|
  bot.listen do |event|
    next unless changes_bot.text_command?(event)

    changes_bot.log_message_receive(event)
    case event.text
    when %r{/get_changes.*}
      text = ''
      changes_bot.repos.each do |cur_repo|
        cur_repo.refs_from_message(event.text)
        text += cur_repo.link_to_changes
      end
      text = 'There is no changes for specified versions' if text.empty?
      bot.api.send_message(chat_id: event.chat.id,
                           text: text,
                           parse_mode: 'html')
    when '/help'
      bot.api.send_message(chat_id: event.chat.id,
                           text: changes_bot.help_message,
                           parse_mode: 'html')
    else
      changes_bot.log_unknown_command(event)
    end
  end
end
