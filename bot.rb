require 'telegram/bot'
require_relative 'github'
config = YAML.load_file('config.yml')

Telegram::Bot::Client.run(config['telegram_bot_token']) do |bot|
  bot.listen do |message|
    case message.text
    when '/get_changes'
      text = ''
      config['repos'].each do |cur_repo|
        text += "#{get_changes_url(cur_repo)}\n"
      end
      bot.api.send_message(chat_id: message.chat.id,
                           text: text,
                           parse_mode: 'Markdown')
    end
  end
end
