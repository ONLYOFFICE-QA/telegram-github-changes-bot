# frozen_string_literal: true

require 'spec_helper'

describe GithubRepoChanges, '#init_github_access' do
  it 'Config read from non-existing file raise an error' do
    expect { described_class.new(config_file: 'foo', force_config_file: true) }.to raise_error(Errno::ENOENT)
  end
end
