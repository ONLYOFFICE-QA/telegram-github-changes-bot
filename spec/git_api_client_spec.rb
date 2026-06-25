# frozen_string_literal: true

require 'spec_helper'

describe GitApiClient do
  it 'works without token' do
    client = described_class.new(api_endpoint: 'https://api.github.com')
    expect(client).to be_a(described_class)
  end

  it 'ref_exist? falls back to git/commits path' do
    url = 'https://api.example.com/repos/org/repo'
    WebMock::API.stub_request(:head, "#{url}/commits/v1.0").to_return(status: 404)
    WebMock::API.stub_request(:get, "#{url}/git/commits/v1.0").to_return(status: 200)
    client = described_class.new(api_endpoint: 'https://api.example.com')
    expect(client.ref_exist?('org/repo', 'v1.0')).to be true
  end
end
