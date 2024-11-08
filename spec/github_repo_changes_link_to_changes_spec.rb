# frozen_string_literal: true

require 'spec_helper'

describe GithubRepoChanges, '#link_to_changes', :vcr do
  let(:github_changes) { changes_bot.repo(name: 'ONLYOFFICE/sdkjs') }

  it 'Check changes for not-existing refs' do
    github_changes.refs_from_message('/get_changes foo...bar')
    expect(github_changes.link_to_changes).to include('There is no')
  end

  it 'Check changes for second non existing ref' do
    github_changes.refs_from_message('/get_changes v5.6.1.6...bar')
    expect(github_changes.link_to_changes).to include('There is no')
  end

  it 'Check empty changes' do
    github_changes.refs_from_message('/get_changes v5.6.1.6...v5.6.2.2')
    expect(github_changes.link_to_changes).to eq('')
  end

  it 'Check repo with skip_if_refs_not_found' do
    repo = changes_bot.repo(name: 'ONLYOFFICE/sdkjs-comparison', skip_if_refs_not_found: true)
    repo.refs_from_message('/get_changes v6.4.1.45...v6.4.2.6')
    expect(repo.link_to_changes).not_to be_empty
  end
end
