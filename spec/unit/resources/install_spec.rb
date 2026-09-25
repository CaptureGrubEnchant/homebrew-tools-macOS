# frozen_string_literal: true

require 'spec_helper'

describe 'homebrew_install' do
  step_into :homebrew_install
  platform 'mac_os_x', '12'

  before do
    allow(Dir).to receive(:home).and_call_original
    allow(Dir).to receive(:home).with('testuser').and_return('/Users/testuser')
    allow(File).to receive(:exist?).and_call_original
    allow(File).to receive(:exist?).with('/opt/homebrew/bin/brew').and_return(false)
    allow_any_instance_of(HomebrewWrapper).to receive(:install_path).and_return('/opt/homebrew')
    allow_any_instance_of(HomebrewWrapper).to receive(:owner).and_return('testuser')
    stub_command('which git').and_return(false)
  end

  context 'with default properties' do
    stubs_for_provider('homebrew_install[default]') do |provider|
      allow(provider).to receive_shell_out('/opt/homebrew/bin/brew analytics state', user: 'testuser')
        .and_return(double(stdout: "Analytics are enabled\n"))
    end

    recipe do
      homebrew_install 'default'
    end

    it { is_expected.to create_sudo('nopasswd_homebrew_installer') }
    it { is_expected.to create_remote_file("#{Chef::Config[:file_cache_path]}/homebrew_go") }
    it { is_expected.to run_execute('install homebrew').with(user: 'testuser') }
    it { is_expected.to install_homebrew_package('git') }
    it { is_expected.to run_execute('update homebrew from github').with(user: 'testuser') }
    it { is_expected.not_to run_execute('set homebrew analytics') }
  end

  context 'with analytics disabled' do
    stubs_for_provider('homebrew_install[default]') do |provider|
      allow(provider).to receive_shell_out('/opt/homebrew/bin/brew analytics state', user: 'testuser')
        .and_return(double(stdout: "Analytics are enabled\n"))
    end

    recipe do
      homebrew_install 'default' do
        enable_analytics false
        auto_update false
      end
    end

    it { is_expected.to run_execute('set homebrew analytics').with(command: '/opt/homebrew/bin/brew analytics off') }
    it { is_expected.not_to install_homebrew_package('git') }
    it { is_expected.not_to run_execute('update homebrew from github') }
  end

  context 'action :delete' do
    before do
      allow(File).to receive(:exist?).with('/opt/homebrew/bin/brew').and_return(true)
    end

    recipe do
      homebrew_install 'default' do
        action :delete
      end
    end

    it { is_expected.to create_remote_file("#{Chef::Config[:file_cache_path]}/homebrew_uninstall") }
    it { is_expected.to run_execute('uninstall homebrew').with(user: 'testuser') }
    it { is_expected.to delete_file("#{Chef::Config[:file_cache_path]}/homebrew_uninstall") }
  end
end
