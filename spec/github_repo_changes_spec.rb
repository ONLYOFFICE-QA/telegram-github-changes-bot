# frozen_string_literal: true

require 'spec_helper'

describe GithubRepoChanges do
  let(:github_changes) { described_class.new(repo: 'ONLYOFFICE/sdkjs') }

  describe 'Check changes without refs' do
    before { github_changes.refs_from_message('/get_changes') }

    it 'expect old_ref is nil' do
      expect(github_changes.old_ref).to be_nil
    end

    it 'expect new_ref is nil' do
      expect(github_changes.new_ref).to be_nil
    end
  end

  it 'Check changes with single ref' do
    github_changes.refs_from_message('/get_changes v4.2.0.73')
    expect(github_changes.old_ref).to eq('v4.2.0.73')
  end

  describe 'Check changes with both ref' do
    before { github_changes.refs_from_message('/get_changes master...develop') }

    it 'expect old_ref is correct' do
      expect(github_changes.old_ref).to eq('master')
    end

    it 'expect new_ref is correct' do
      expect(github_changes.new_ref).to eq('develop')
    end
  end

  it 'Check correct message if single ref - is the latest ref' do
    github_changes.fetch_refs
    newset_ref = github_changes.refs.first
    github_changes.refs_from_message("/get_changes #{newset_ref}")
    expect(github_changes.link_to_changes)
      .to match(/Your specified version is the latest version/)
  end
end
