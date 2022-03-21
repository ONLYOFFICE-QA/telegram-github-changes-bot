# frozen_string_literal: true

require 'telegram/bot'
require_relative 'telegram_github_changes_bot/github_repo_changes'

# Main class for application
class TelegramGithubChangesBot
  def initialize(config = JSON.parse(File.read('./config.json'), symbolize_names: true))
    @config = config
    @repos = []
    read_github_auth_data
    @octokit = Octokit::Client.new(login: @user_name, password: @user_password)
    @octokit.auto_paginate = true
  end

  # @return [Array<GithubRepoChanges>] list of repos
  def repos
    return @repos unless @repos.empty?

    @config[:repos].each do |cur_repo|
      @repos << repo(cur_repo)
    end

    @repos
  end

  # @return [GithubRepoChanges] single repo with data
  def repo(params)
    GithubRepoChanges.new(repo: params[:name],
                          octokit: @octokit,
                          skip_if_refs_not_found: params[:skip_if_refs_not_found])
  end

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

  def read_github_auth_data
    @user_name = @config[:github_user]
    @user_password = @config[:github_user_password]
  end
end
