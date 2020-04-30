# frozen_string_literal: true

require 'spec_helper'

describe TelegramHelper, '.sanitize_message' do
  it 'do not sanitize simple message' do
    expect(described_class.sanitize_message('test')).to eq('test')
  end

  it 'sanitize underscore symbol' do
    expect(described_class.sanitize_message('a_a')).to eq('a\_a')
  end
end
