# frozen_string_literal: true

require_relative 'lib/telegram_github_changes_bot'
config = YAML.load_file('config.yml')
changes_bot = TelegramGithubChangesBot.new(config)

Telegram::Bot::Client.run(config['telegram_bot_token']) do |bot|
  bot.listen do |message|
    changes_bot.log_message_receive(message)
    case message.text
    when %r{/get_changes.*}
      text = ''
      changes_bot.repos.each do |cur_repo|
        cur_repo.refs_from_message(message.text)
        text += cur_repo.link_to_changes
      end
      text = 'There is no changes for specified versions' if text.empty?
      bot.api.send_message(chat_id: message.chat.id,
                           text: text,
                           parse_mode: 'html')
    when '/help'
      bot.api.send_message(chat_id: message.chat.id,
                           text: changes_bot.help_message,
                           parse_mode: 'html')
    else
      changes_bot.log_unknown_command(message)
    end
  end
end
