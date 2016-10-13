require 'spec_helper'

describe GithubRepoChanges do
  let(:github_changes) { GithubRepoChanges.new(repo: 'ONLYOFFICE/sdkjs') }

  it 'Check changes without refs' do
    github_changes.refs_from_message('/get_changes')
    expect(github_changes.old_ref).to be_nil
    expect(github_changes.new_ref).to be_nil
  end

  it 'Check changes with single ref' do
    github_changes.refs_from_message('/get_changes v4.2.0.73')
    expect(github_changes.old_ref).to eq('v4.2.0.73')
  end

  it 'Check changes with both ref' do
    github_changes.refs_from_message('/get_changes master...develop')
    expect(github_changes.old_ref).to eq('master')
    expect(github_changes.new_ref).to eq('develop')
  end
end
