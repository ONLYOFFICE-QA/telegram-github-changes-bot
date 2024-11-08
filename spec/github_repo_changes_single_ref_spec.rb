# frozen_string_literal: true

require 'spec_helper'

describe GithubRepoChanges, :vcr do
  let(:github_changes) { changes_bot.repo(name: 'ONLYOFFICE/sdkjs') }

  it 'Check changes with single ref' do
    github_changes.refs_from_message('/get_changes v4.2.0.73')
    expect(github_changes.old_ref).to eq('v4.2.0.73')
  end

  it 'Check correct message if single ref - is the latest ref' do
    github_changes.fetch_refs
    newest_ref = github_changes.refs.first
    github_changes.refs_from_message("/get_changes #{newest_ref}")
    expect(github_changes.link_to_changes)
      .to match(/Your specified version is the latest version/)
  end

  it 'check empty changes with skip_if_refs_not_found' do
    repo = changes_bot.repo(name: 'ONLYOFFICE/DocumentServer', skip_if_refs_not_found: true)
    repo.refs_from_message('/get_changes 123...456')
    expect(repo.link_to_changes).to be_empty
  end
end
