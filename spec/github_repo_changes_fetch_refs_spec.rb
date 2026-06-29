# frozen_string_literal: true

require 'spec_helper'

describe GithubRepoChanges do
  it 'fetch_refs sets new_ref to nil when repo has no tags' do
    client = instance_double(GitApiClient, latest_tag: nil)
    repo = described_class.new(repo: 'test/empty', client: client)
    repo.fetch_refs
    expect(repo.new_ref).to be_nil
  end

  it 'fetch_refs does not set old_ref' do
    client = instance_double(GitApiClient, latest_tag: { name: 'v1.0' })
    repo = described_class.new(repo: 'test/repo', client: client)
    repo.fetch_refs
    expect(repo.old_ref).to be_nil
  end

  it 'fetch_refs sets new_ref from latest tag' do
    client = instance_double(GitApiClient, latest_tag: { name: 'v1.0' })
    repo = described_class.new(repo: 'test/repo', client: client)
    repo.fetch_refs
    expect(repo.new_ref).to eq('v1.0')
  end

  it 'fetch_refs skips when both refs already set' do
    repo = described_class.new(repo: 'test/repo', client: instance_double(GitApiClient))
    repo.old_ref = 'v1.0'
    repo.new_ref = 'v2.0'
    repo.fetch_refs
    expect(repo.new_ref).to eq('v2.0')
  end
end
