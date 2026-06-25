# frozen_string_literal: true

require 'faraday'
require 'faraday/retry'
require 'json'

# Simple API client for Gitea/GitHub compatible servers
class GitApiClient
  def initialize(api_endpoint:, token: nil)
    @connection = Faraday.new(url: api_endpoint) do |f|
      f.request :retry
      f.request :authorization, 'token', token if token
      f.response :raise_error
      f.options.timeout = 60
    end
  end

  # @param repo [String] repo in "owner/name" format
  # @return [Hash, nil] latest tag or nil
  def latest_tag(repo)
    response = @connection.get("repos/#{repo}/tags", page: 1, per_page: 1, limit: 1)
    JSON.parse(response.body, symbolize_names: true).first
  end

  # @param repo [String] repo in "owner/name" format
  # @param base [String] base ref
  # @param head [String] head ref
  # @return [Hash] compare result with :commits array
  def compare(repo, base, head)
    response = @connection.get("repos/#{repo}/compare/#{base}...#{head}")
    JSON.parse(response.body, symbolize_names: true)
  end

  # @param repo [String] repo in "owner/name" format
  # @param ref [String] ref name (tag, branch, or sha)
  # @return [Boolean] true if ref exists
  def ref_exist?(repo, ref)
    @connection.head("repos/#{repo}/commits/#{ref}")
    true
  rescue Faraday::ResourceNotFound, Faraday::UnprocessableEntityError
    begin
      # Gitea uses git/commits path and does not support HEAD on it
      @connection.get("repos/#{repo}/git/commits/#{ref}")
      true
    rescue Faraday::ResourceNotFound, Faraday::UnprocessableEntityError
      false
    end
  end
end
