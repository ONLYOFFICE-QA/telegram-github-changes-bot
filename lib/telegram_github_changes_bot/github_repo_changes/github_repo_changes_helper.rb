# Helper for working with repo
module GithubRepoChangesHelper
  # Fetch any number of tags from message
  # @param message [String] message to handle
  # @return [String, String] two split strings
  def refs_from_message(message)
    return fetch_two_tags(message) if message.include?('...')
    return fetch_one_tag(message) if message.include?(' ')
    @old_tag = nil
    @new_tag = nil
  end

  # Fetch both tags from message
  # @param message [String] message to handle
  # @return [Nothing]
  def fetch_two_tags(message)
    tags_with_dots = message.match(/.* (.*\.\.\..*)/)[1]
    @old_tag, @new_tag = tags_with_dots.split('...')
  end

  # Fetch one tag from message
  # @param message [String] message to handle
  # @return [Nothing]
  def fetch_one_tag(message)
    @old_tag = message.match(/.* (.*)/)[1]
    @new_tag = nil
  end
end
