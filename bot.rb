require_relative 'lib/telegram_github_changes_bot.rb'
config = YAML.load_file('config.yml')
repos_changes_array = []

config['repos'].each do |cur_repo|
  repos_changes_array << GithubRepoChanges.new(repo: cur_repo)
end

Telegram::Bot::Client.run(config['telegram_bot_token']) do |bot|
  begin
    bot.listen do |message|
      case message.text
      when %r{/get_changes.*}
        text = ''
        repos_changes_array.each do |cur_repo|
          cur_repo.refs_from_message(message.text)
          text += cur_repo.link_to_changes
        end
        text = 'There is no changes for specified versions' if text.empty?
        bot.api.send_message(chat_id: message.chat.id,
                             text: text,
                             parse_mode: 'Markdown')
      end
    end
  end
end
