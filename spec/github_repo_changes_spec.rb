# frozen_string_literal: true

require 'spec_helper'

describe GithubRepoChanges, :vcr do
  let(:github_changes) { changes_bot.repo(name: 'ONLYOFFICE/sdkjs') }

  before { github_changes.refs_from_message('/get_changes v4.2.0.73...v4.2.0.74') }

  it 'expect old_ref is correct' do
    expect(github_changes.old_ref).to eq('v4.2.0.73')
  end

  it 'expect new_ref is correct' do
    expect(github_changes.new_ref).to eq('v4.2.0.74')
  end

  it 'Check changes for existing refs' do
    expect(github_changes.link_to_changes).to include('/compare/')
  end
end
