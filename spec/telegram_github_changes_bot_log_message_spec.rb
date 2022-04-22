# frozen_string_literal: true

require 'spec_helper'

describe TelegramGithubChangesBot, '#log_message' do
  let(:bot) { described_class.new }
  let(:message) { instance_double(message) }
  let(:message_from) { instance_double(from) }

  before do
    allow(message_from).to receive(:username).and_return('custom_username')
    allow(message).to receive(:text).and_return('Message text')
    allow(message).to receive(:from) { message_from }
  end

  it 'bot#log_message_receive output to stdout' do
    expect { bot.log_message_receive(message) }.to output(/Got message/).to_stdout
  end

  it 'bot#log_unknown_command output to stdout' do
    expect { bot.log_unknown_command(message) }.to output(/unsupported/).to_stdout
  end
end
