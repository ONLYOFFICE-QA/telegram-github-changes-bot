# frozen_string_literal: true

require 'logger'
require 'octokit'
require 'yaml'
require_relative 'github_repo_changes/github_repo_changes_helper'
require_relative 'github_repo_changes/ref_helper'

# Class for describing changes for github repo
class GithubRepoChanges
  # @return [String] message if version is latest
  SAME_MESSAGE = 'Your specified version is the latest version'
  include GithubRepoChangesHelper
  include RefHelper
  attr_reader :version_regex
  # @return [String] name of old ref
  attr_accessor :old_ref
  # @return [String] name of new ref
  attr_accessor :new_ref
  # @return [Array<String>] list of refs
  attr_accessor :refs

  def initialize(config_file: 'config.yml',
                 force_config_file: false,
                 repo: nil)
    init_github_access(config_file,
                       force_file_read: force_config_file)
    @repo = repo
    @logger = Logger.new($stdout)
    Octokit.configure do |c|
      c.login = @user_name
      c.password = @user_password
    end
  end

  # @return [String] url to changes
  def changes_url
    "https://github.com/#{@repo}/compare/#{@old_ref}...#{@new_ref}"
  end

  # @return [True, False] is changes empty
  def changes_empty?
    changes = Octokit.compare(@repo, @old_ref, @new_ref)
    changes[:files].empty?
  end

  # @return [String] link to changes to send in message
  def link_to_changes
    @logger.info("Fetching changes for `#{@repo}` "\
                          "between `#{@old_ref}` and `#{@new_ref}`")
    fetch_refs
    return "There is no #{@old_ref} in #{@repo}\n" unless ref_exist?(@old_ref)
    return "There is no #{@new_ref} in #{@repo}\n" unless ref_exist?(@new_ref)
    return "#{@repo}: #{SAME_MESSAGE}" if @old_ref == @new_ref
    return '' if changes_empty?

    "[#{@repo} changes #{@old_ref}..."\
    "#{@new_ref}](#{changes_url})\n"
  end

  private

  def init_github_access(config, force_file_read: false)
    @user_name = ENV['CHANGES_BOT_GH_USER_NAME']
    @user_password = ENV['CHANGES_BOT_GH_USER_PASSWORD']
    return unless File.exist?(config) || force_file_read

    @config = YAML.load_file(config)
    @user_name = @config['github_user']
    @user_password = @config['github_user_password']
  end
end
