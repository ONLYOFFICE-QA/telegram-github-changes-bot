# frozen_string_literal: true

require 'spec_helper'

describe GithubRepoChanges, '#init_github_access' do
  it 'Config read from non-existing file raise an error' do
    expect { described_class.new(config_file: 'foo', force_config_file: true) }.to raise_error(Errno::ENOENT)
  end

  it 'Config read with correct non-existing data will not raise an error' do
    config = "#{Dir.pwd}/spec/fake-config.yml"
    expect { described_class.new(config_file: config, force_config_file: true) }.not_to raise_error
  end
end
