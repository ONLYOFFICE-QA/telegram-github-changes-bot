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
  # @return [String] name of old ref
  attr_accessor :old_ref
  # @return [String] name of new ref
  attr_accessor :new_ref
  # @return [Array<String>] list of refs
  attr_accessor :refs

  def initialize(repo: nil, octokit: nil)
    @repo = repo
    @octokit = octokit
    @logger = Logger.new($stdout)
  end

  # @return [String] url to changes
  def changes_url
    "https://github.com/#{@repo}/compare/#{@old_ref}...#{@new_ref}"
  end

  # @return [True, False] is changes empty
  def changes_empty?
    changes = @octokit.compare(@repo, @old_ref, @new_ref)
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

    changes_text = "#{@repo} changes #{@old_ref}..."\
                   "#{@new_ref}"
    "<a href='#{changes_url}'>#{changes_text}</a>\n"
  end
end
