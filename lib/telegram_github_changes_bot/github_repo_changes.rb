require 'octokit'
require 'yaml'
require_relative 'github_repo_changes/github_repo_changes_helper'

# Class for describing changes for github repo
class GithubRepoChanges
  include GithubRepoChangesHelper
  attr_reader :version_regex
  attr_accessor :old_tag
  attr_accessor :new_tag
  def initialize(config_file: 'config.yml',
                 repo: nil)
    return if config_file.nil?
    @config = YAML.load_file(config_file)
    @repo = repo
    @version_regex = /#{@config['version_regexp']}/
    Octokit.configure do |c|
      c.login = @config['github_user']
      c.password = @config['github_user_password']
    end
  end

  def tag_names
    tags = []
    Octokit.tags(@repo).each do |current_tag|
      tags << current_tag['name']
    end
    tags
  end

  def fetch_tags
    tags = tag_names
    @new_tag = tags[0] unless @new_tag
    @old_tag = tags[1] unless @old_tag
  end

  def changes_url
    "https://github.com/#{@repo}/compare/#{@old_tag}...#{@new_tag}"
  end

  def changes_empty?
    changes = Octokit.compare(@repo, @old_tag, @new_tag)
    changes[:files].empty?
  end

  def link_to_changes
    fetch_tags
    return '' if changes_empty?
    "[#{@repo} changes #{@old_tag}..."\
    "#{@new_tag}](#{changes_url})\n"
  end
end
