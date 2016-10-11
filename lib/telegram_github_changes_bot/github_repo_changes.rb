require 'octokit'
require 'yaml'

# Class for describing changes for github repo
class GithubRepoChanges
  attr_reader :version_regex
  def initialize(config_file: 'config.yml',
                 repo: nil)
    @config = YAML.load_file(config_file)
    @repo = repo
    @tags_filter = @config['tags_filter']
    @version_regex = /#{@config['version_regexp']}/
    Octokit.configure do |c|
      c.login = @config['github_user']
      c.password = @config['github_user_password']
    end
    Octokit.auto_paginate = true
  end

  # @param string [String] string for check
  # @return [True, False] check if tag matches regexp
  def tag_match?(string)
    (string =~ /#{@tags_filter}\d/).nil?
  end

  def tag_names
    tags = []
    Octokit.tags(@repo).each do |current_tag|
      tags << current_tag['name'] unless tag_match?(current_tag['name'])
    end
    tags
  end

  def fetch_latest_tags
    tags = tag_names
    @new_tag = tags[0]
    @old_tag = tags[1]
  end

  def changes_url
    "https://github.com/#{@repo}/compare/#{@old_tag}...#{@new_tag}"
  end

  def changes_empty?
    changes = Octokit.compare(@repo, @old_tag, @new_tag)
    changes[:files].empty?
  end

  def link_to_changes(specific_version = nil)
    fetch_latest_tags
    @old_tag = "#{@tags_filter}#{specific_version}" unless specific_version.nil?
    return '' if changes_empty?
    "[#{@repo} changes v.#{@old_tag.gsub(@tags_filter, '')} -"\
    "v.#{@new_tag.gsub(@tags_filter, '')}](#{changes_url})\n"
  end
end
