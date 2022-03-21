# frozen_string_literal: true

require 'spec_helper'

describe GithubRepoChanges, '#link_to_changes' do
  let(:github_changes) { changes_bot.repo('ONLYOFFICE/sdkjs') }

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
end
