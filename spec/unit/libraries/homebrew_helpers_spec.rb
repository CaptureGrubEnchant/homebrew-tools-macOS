# frozen_string_literal: true

require 'spec_helper'
require 'chef/mixin/shell_out'

RSpec.describe HomebrewCookbook::Helpers do
  let(:homebrew) { HomebrewWrapper.new }

  describe '#install_path' do
    it 'returns /opt/homebrew for ARM-based systems' do
      allow(homebrew).to receive(:shell_out).with('sysctl -n hw.optional.arm64').and_return(double(stdout: "1\n"))
      expect(homebrew.install_path).to eq('/opt/homebrew')
    end

    it 'returns /usr/local for non-ARM systems' do
      allow(homebrew).to receive(:shell_out).with('sysctl -n hw.optional.arm64').and_return(double(stdout: "0\n"))
      expect(homebrew.install_path).to eq('/usr/local')
    end
  end

  describe '#repository_path' do
    it 'returns /opt/homebrew for ARM-based systems' do
      allow(homebrew).to receive(:shell_out).with('sysctl -n hw.optional.arm64').and_return(double(stdout: "1\n"))
      expect(homebrew.repository_path).to eq('/opt/homebrew')
    end

    it 'returns /usr/local/Homebrew for non-ARM systems' do
      allow(homebrew).to receive(:shell_out).with('sysctl -n hw.optional.arm64').and_return(double(stdout: "0\n"))
      expect(homebrew.repository_path).to eq('/usr/local/Homebrew')
    end
  end

  describe '#owner' do
    it 'returns the homebrew owner' do
      user_wrapper = double('HomebrewUserWrapper', find_homebrew_username: 'testuser')
      allow(HomebrewUserWrapper).to receive(:new).and_return(user_wrapper)
      expect(homebrew.owner).to eq('testuser')
    end
  end

  describe '#homebrew_user_environment' do
    it 'returns the HOME and USER environment' do
      allow(Dir).to receive(:home).with('testuser').and_return('/Users/testuser')
      expect(homebrew.homebrew_user_environment('testuser')).to eq(
        'HOME' => '/Users/testuser',
        'USER' => 'testuser'
      )
    end
  end

  describe '#tap_directory' do
    it 'returns the Homebrew tap directory fragment' do
      expect(homebrew.tap_directory('hashicorp/tap')).to eq('hashicorp/homebrew-tap')
    end
  end
end
