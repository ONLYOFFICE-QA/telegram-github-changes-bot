require 'octokit'
require 'yaml'
require_relative 'github_repo_changes/github_repo_changes_helper'
require_relative 'github_repo_changes/ref_helper'

# Class for describing changes for github repo
class GithubRepoChanges
  SAME_MESSAGE = 'Your specified version is the latest version'.freeze
  include GithubRepoChangesHelper
  include RefHelper
  attr_reader :version_regex
  attr_accessor :old_ref
  attr_accessor :new_ref
  attr_accessor :refs
  def initialize(config_file: 'config.yml',
                 repo: nil)
    init_github_access(config_file)
    @repo = repo
    Octokit.configure do |c|
      c.login = @user_name
      c.password = @user_password
    end
  end

  def changes_url
    "https://github.com/#{@repo}/compare/#{@old_ref}...#{@new_ref}"
  end

  def changes_empty?
    changes = Octokit.compare(@repo, @old_ref, @new_ref)
    changes[:files].empty?
  end

  def link_to_changes
    fetch_refs
    return "There is no #{@old_ref} in #{@repo}\n" unless ref_exist?(@old_ref)
    return "There is no #{@new_ref} in #{@repo}\n" unless ref_exist?(@new_ref)
    return "#{@repo}: #{SAME_MESSAGE}" if @old_ref == @new_ref
    return '' if changes_empty?

    "[#{@repo} changes #{@old_ref}..."\
    "#{@new_ref}](#{changes_url})\n"
  end

  private

  def init_github_access(config)
    @user_name = ENV['GITHUB_USER_NAME']
    @user_password = ENV['GITHUB_USER_PASSWORD']
    return unless File.exist?(config)

    @config = YAML.load_file(config)
    @user_name = @config['github_user']
    @user_password = @config['github_user_password']
  end
end
