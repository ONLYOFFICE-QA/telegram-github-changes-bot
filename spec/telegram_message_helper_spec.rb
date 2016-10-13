require 'spec_helper'

describe GithubRepoChanges do
  let(:github_changes) { GithubRepoChanges.new(config_file: nil) }
  describe 'refs_from_message' do
    it 'refs_from_message with two refs' do
      github_changes.refs_from_message('/get_changes v1...v2')
      expect(github_changes.old_ref).to eq('v1')
      expect(github_changes.new_ref).to eq('v2')
    end

    it 'refs_from_message with single ref' do
      github_changes.refs_from_message('/get_changes v1')
      expect(github_changes.old_ref).to eq('v1')
      expect(github_changes.new_ref).to be_nil
    end

    it 'refs_from_message without refs' do
      github_changes.refs_from_message('/get_changes')
      expect(github_changes.old_ref).to be_nil
      expect(github_changes.new_ref).to be_nil
    end
  end
end
