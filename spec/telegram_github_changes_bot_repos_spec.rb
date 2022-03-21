# frozen_string_literal: true

require 'spec_helper'

describe TelegramGithubChangesBot, '#repos' do
  it 'bot#repos is array of GithubRepoChanges' do
    expect(changes_bot.repos).to all(be_a(GithubRepoChanges))
  end

  it 'bot#repos is read only once after init' do
    changes_bot.repos
    expect(changes_bot.repos).to all(be_a(GithubRepoChanges))
  end
end
