# frozen_string_literal: true

require 'spec_helper'

describe GithubRepoChanges, :vcr do
  let(:github_changes) { changes_bot.repo(name: 'ONLYOFFICE/sdkjs') }

  describe 'Check changes without refs' do
    before { github_changes.refs_from_message('/get_changes') }

    it 'expect old_ref is nil' do
      expect(github_changes.old_ref).to be_nil
    end

    it 'expect new_ref is nil' do
      expect(github_changes.new_ref).to be_nil
    end
  end
end
