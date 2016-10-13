require 'octokit'
require 'yaml'
require_relative 'github_repo_changes/github_repo_changes_helper'
require_relative 'github_repo_changes/ref_helper'

# Class for describing changes for github repo
class GithubRepoChanges
  include GithubRepoChangesHelper
  include RefHelper
  attr_reader :version_regex
  attr_accessor :old_ref
  attr_accessor :new_ref
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
    return '' if changes_empty?
    "[#{@repo} changes #{@old_ref}..."\
    "#{@new_ref}](#{changes_url})\n"
  end
end
