require 'telegram/bot'
require_relative 'github_repo_changes'
config = YAML.load_file('config.yml')
repos_changes_array = []

config['repos'].each do |cur_repo|
  repos_changes_array << GithubRepoChanges.new(repo: cur_repo)
end

Telegram::Bot::Client.run(config['telegram_bot_token']) do |bot|
  bot.listen do |message|
    case message.text
    when '/get_changes'
      text = ''
      repos_changes_array.each do |cur_repo|
        text += cur_repo.link_to_changes
      end
      text = 'There is no changes for latest version' if text.empty?
      bot.api.send_message(chat_id: message.chat.id,
                           text: text,
                           parse_mode: 'Markdown')
    end
  end
end
