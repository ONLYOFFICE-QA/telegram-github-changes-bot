# frozen_string_literal: true

require 'spec_helper'

describe TelegramGithubChangesBot, '#text_command' do
  let(:bot) { described_class.new }

  it 'some random object is not a text_command' do
    expect(bot).not_to be_text_command(Object)
  end

  it 'if object has message in it - it is a text command' do
    message = double
    allow(message).to receive(:text).and_return('myCustomMessage')
    expect(bot).to be_text_command(message)
  end
end
