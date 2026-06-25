# frozen_string_literal: true

# Classes for working with refs
module RefHelper
  # Check if current ref is exists
  # @param ref_name [String] name of ref
  # @return [Boolean] true if ref exists
  def ref_exist?(ref_name)
    @client.ref_exist?(@repo, ref_name)
  end

  # Fetch refs values (fill @new_ref and @old_ref)
  # @return [nil]
  def fetch_refs
    return if @new_ref && @old_ref

    latest = @client.latest_tag(@repo)
    @new_ref ||= latest&.dig(:name)
    @old_ref ||= latest&.dig(:name)
    nil
  end

  private

  # Check if stored refs are existing
  # @return [void]
  def check_ref_existence
    @old_ref_exists = ref_exist?(@old_ref)
    @new_ref_exists = ref_exist?(@new_ref)
  end

  # @return [Boolean] if non-existing refs allowed
  def non_existing_refs_allowed?
    return true if @skip_if_refs_not_found && (!@old_ref_exists || !@new_ref_exists)

    false
  end
end
