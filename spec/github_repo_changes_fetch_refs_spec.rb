# frozen_string_literal: true

require 'spec_helper'

describe GithubRepoChanges do
  it 'fetch_refs sets new_ref to nil when repo has no tags' do
    client = instance_double(GitApiClient, latest_tag: nil)
    repo = described_class.new(repo: 'test/empty', client: client)
    repo.fetch_refs
    expect(repo.new_ref).to be_nil
  end

  it 'fetch_refs sets old_ref to nil when repo has no tags' do
    client = instance_double(GitApiClient, latest_tag: nil)
    repo = described_class.new(repo: 'test/empty', client: client)
    repo.fetch_refs
    expect(repo.old_ref).to be_nil
  end
end
