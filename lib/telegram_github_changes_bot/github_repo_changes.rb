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

  def initialize(repo: nil,
                 octokit: nil,
                 skip_if_refs_not_found: false)
    @repo = repo
    @octokit = octokit
    @logger = Logger.new($stdout)
    @skip_if_refs_not_found = skip_if_refs_not_found
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
    check_ref_existence

    return '' if non_existing_refs_allowed?
    return "There is no #{@old_ref} in #{@repo}\n" unless @old_ref_exists
    return "There is no #{@new_ref} in #{@repo}\n" unless @new_ref_exists
    return "#{@repo}: #{SAME_MESSAGE}" if @old_ref == @new_ref
    return '' if changes_empty?

    changes_link
  end

  # @return [String] url to changes
  def changes_url
    "https://github.com/#{@repo}/compare/#{@old_ref}...#{@new_ref}"
  end

  # @return [String] changes text
  def changes_text
    "#{@repo} changes #{@old_ref}..."\
      "#{@new_ref}"
  end

  # @return [String] link to changes text
  def changes_link
    "<a href='#{changes_url}'>#{changes_text}</a>\n"
  end
end
