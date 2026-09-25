# frozen_string_literal: true

require 'spec_helper'

describe 'homebrew_cask_app' do
  step_into :homebrew_cask_app, :homebrew_tap_repo
  platform 'mac_os_x', '12'

  before do
    allow(Dir).to receive(:home).and_call_original
    allow(Dir).to receive(:home).with('testuser').and_return('/Users/testuser')
    allow(File).to receive(:directory?).and_call_original
    allow(File).to receive(:directory?).with('/opt/homebrew/Library/Taps/homebrew/homebrew-cask').and_return(false)
    allow(File).to receive(:directory?).with('/opt/homebrew/Caskroom/caffeine').and_return(false)
    allow(File).to receive(:directory?).with('/opt/homebrew/Caskroom/google-chrome').and_return(false)
    allow_any_instance_of(HomebrewWrapper).to receive(:install_path).and_return('/opt/homebrew')
    allow_any_instance_of(HomebrewWrapper).to receive(:repository_path).and_return('/opt/homebrew')
    allow_any_instance_of(HomebrewWrapper).to receive(:owner).and_return('testuser')
  end

  context 'with default properties' do
    recipe do
      homebrew_cask_app 'caffeine'
    end

    it { is_expected.to run_execute('tap homebrew/cask') }
    it { is_expected.to run_execute('install cask caffeine').with(command: '/opt/homebrew/bin/brew install --cask caffeine') }
  end

  context 'with options and no cask tap install' do
    recipe do
      homebrew_cask_app 'google-chrome' do
        options '--appdir=/Applications'
        install_cask false
      end
    end

    it { is_expected.not_to run_execute('tap homebrew/cask') }
    it do
      is_expected.to run_execute('install cask google-chrome').with(
        command: '/opt/homebrew/bin/brew install --cask google-chrome --appdir=/Applications'
      )
    end
  end

  context 'action :remove' do
    before do
      allow(File).to receive(:directory?).with('/opt/homebrew/Caskroom/caffeine').and_return(true)
    end

    recipe do
      homebrew_cask_app 'caffeine' do
        action :remove
      end
    end

    it { is_expected.to run_execute('remove cask caffeine').with(command: '/opt/homebrew/bin/brew uninstall --cask caffeine') }
  end
end
