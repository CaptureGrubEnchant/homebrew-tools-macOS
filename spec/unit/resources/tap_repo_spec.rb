# frozen_string_literal: true

require 'spec_helper'

describe 'homebrew_tap_repo' do
  step_into :homebrew_tap_repo
  platform 'mac_os_x', '12'

  before do
    allow(Dir).to receive(:home).and_call_original
    allow(Dir).to receive(:home).with('testuser').and_return('/Users/testuser')
    allow(File).to receive(:directory?).and_call_original
    allow(File).to receive(:directory?).with('/opt/homebrew/Library/Taps/hashicorp/homebrew-tap').and_return(false)
    allow_any_instance_of(HomebrewWrapper).to receive(:install_path).and_return('/opt/homebrew')
    allow_any_instance_of(HomebrewWrapper).to receive(:repository_path).and_return('/opt/homebrew')
    allow_any_instance_of(HomebrewWrapper).to receive(:owner).and_return('testuser')
  end

  context 'with default properties' do
    recipe do
      homebrew_tap_repo 'hashicorp/tap'
    end

    it { is_expected.to run_execute('tap hashicorp/tap').with(command: '/opt/homebrew/bin/brew tap hashicorp/tap') }
  end

  context 'with legacy full property and URL' do
    recipe do
      homebrew_tap_repo 'hashicorp/tap' do
        full true
        url 'https://github.com/hashicorp/homebrew-tap.git'
      end
    end

    it do
      is_expected.to run_execute('tap hashicorp/tap').with(
        command: '/opt/homebrew/bin/brew tap hashicorp/tap https://github.com/hashicorp/homebrew-tap.git'
      )
    end
  end

  context 'action :untap' do
    before do
      allow(File).to receive(:directory?).with('/opt/homebrew/Library/Taps/hashicorp/homebrew-tap').and_return(true)
    end

    recipe do
      homebrew_tap_repo 'hashicorp/tap' do
        action :untap
      end
    end

    it { is_expected.to run_execute('untap hashicorp/tap').with(command: '/opt/homebrew/bin/brew untap hashicorp/tap') }
  end
end
