# frozen_string_literal: true

require 'spec_helper'

describe TelegramGithubChangesBot, '#help_message' do
  let(:bot) { described_class.new }

  it 'bot#help_message return string' do
    expect(bot.help_message).to be_a(String)
  end

  it 'bot#help_message result is multiple strings' do
    expect(bot.help_message.split("\n").length).to be > 1
  end
end
