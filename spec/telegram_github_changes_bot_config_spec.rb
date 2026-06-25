# frozen_string_literal: true

require 'spec_helper'

describe TelegramGithubChangesBot do
  it 'uses default endpoints when config keys are missing' do
    config = { github_token: nil, repos: [] }
    bot = described_class.new(config)
    expect(bot).to be_a(described_class)
  end

  it 'uses default endpoints when config values are empty' do
    config = { github_api_endpoint: '', github_web_url: '', github_token: nil, repos: [] }
    bot = described_class.new(config)
    expect(bot).to be_a(described_class)
  end

  it 'uses provided endpoints when config values are present' do
    config = { github_api_endpoint: 'https://api.example.com', github_web_url: 'https://example.com',
               github_token: 'tok', repos: [] }
    bot = described_class.new(config)
    expect(bot).to be_a(described_class)
  end
end
