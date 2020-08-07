# frozen_string_literal: true

# Classes for working with refs
module RefHelper
  # Get list of refs names
  # Set `@refs` variable
  # @return [Array<String>] list of refs
  def refs_names
    Octokit.auto_paginate = true
    @refs = []
    Octokit.tags(@repo).each do |current_tag|
      @refs << current_tag['name']
    end
    Octokit.branches(@repo).each do |current_branch|
      @refs << current_branch['name']
    end
    @refs
  end

  # Check if current ref is exists
  # @param ref_name [String] name of ref
  # @return [True, false]
  def ref_exist?(ref_name)
    @refs.each do |current_ref|
      return true if current_ref == ref_name
    end
    false
  end

  # Fetch refs values (fill @new_ref and @old_ref)
  # @return [nil]
  def fetch_refs
    refs = refs_names
    @new_ref ||= refs[0]
    @old_ref ||= refs[1]
    nil
  end
end
