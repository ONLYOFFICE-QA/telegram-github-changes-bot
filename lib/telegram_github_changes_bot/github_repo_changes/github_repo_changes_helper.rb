# frozen_string_literal: true

# Helper for working with repo
module GithubRepoChangesHelper
  # Fetch any number of refs from message
  # @param message [String] message to handle
  # @return [String, String] two split strings
  def refs_from_message(message)
    return fetch_two_refs(message) if message.include?('...')
    return fetch_one_refs(message) if message.include?(' ')

    @old_ref = nil
    @new_ref = nil
  end

  # Fetch both refs from message
  # @param message [String] message to handle
  # @return [Nothing]
  def fetch_two_refs(message)
    refs_with_dots = message.match(/.* (.*\.\.\..*)/)[1]
    @old_ref, @new_ref = refs_with_dots.split('...')
  end

  # Fetch one ref from message
  # @param message [String] message to handle
  # @return [Nothing]
  def fetch_one_refs(message)
    @old_ref = message.match(/.* (.*)/)[1]
    @new_ref = nil
  end
end
