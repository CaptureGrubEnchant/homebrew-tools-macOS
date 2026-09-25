# frozen_string_literal: true

provides :homebrew_install
unified_mode true

use '_partial/_homebrew'

property :installer_url, String, default: 'https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh'
property :installer_checksum, String
property :uninstaller_url, String, default: 'https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh'
property :uninstaller_checksum, String
property :auto_update, [true, false], default: true
property :enable_analytics, [true, false], default: true

default_action :install

action :install do
  homebrew_go = "#{Chef::Config[:file_cache_path]}/homebrew_go"

  unless homebrew_exists?(new_resource.homebrew_path)
    sudo 'nopasswd_homebrew_installer' do
      user new_resource.owner
      commands [
        homebrew_go,
        '/bin/chmod',
        '/bin/mkdir',
        '/bin/rm',
        '/usr/bin/chgrp',
        '/usr/bin/install',
        '/usr/bin/touch',
        '/usr/bin/xcode-select',
        '/usr/sbin/chown',
        '/usr/sbin/softwareupdate',
      ]
      nopasswd true
      action :create
      notifies :delete, 'sudo[nopasswd_homebrew_installer]', :delayed
    end

    remote_file homebrew_go do
      source new_resource.installer_url
      checksum new_resource.installer_checksum if new_resource.installer_checksum
      mode '0755'
      retries 2
    end

    execute 'install homebrew' do
      command homebrew_go
      environment lazy { homebrew_user_environment(new_resource.owner).merge('NONINTERACTIVE' => '1') }
      user new_resource.owner
    end
  end

  execute 'set homebrew analytics' do
    command lazy { "#{new_resource.homebrew_path} analytics #{new_resource.enable_analytics ? 'on' : 'off'}" }
    environment lazy { homebrew_user_environment(new_resource.owner) }
    user new_resource.owner
    only_if { homebrew_analytics_enabled?(new_resource.homebrew_path, new_resource.owner) != new_resource.enable_analytics }
  end

  if new_resource.auto_update
    homebrew_package 'git' do
      not_if 'which git'
    end

    execute 'update homebrew from github' do
      command lazy { "#{new_resource.homebrew_path} update || true" }
      environment lazy { homebrew_user_environment(new_resource.owner) }
      user new_resource.owner
    end
  end
end

action :delete do
  homebrew_uninstall = "#{Chef::Config[:file_cache_path]}/homebrew_uninstall"

  remote_file homebrew_uninstall do
    source new_resource.uninstaller_url
    checksum new_resource.uninstaller_checksum if new_resource.uninstaller_checksum
    mode '0755'
    retries 2
    only_if { homebrew_exists?(new_resource.homebrew_path) }
  end

  execute 'uninstall homebrew' do
    command homebrew_uninstall
    environment lazy { homebrew_user_environment(new_resource.owner).merge('NONINTERACTIVE' => '1') }
    user new_resource.owner
    only_if { homebrew_exists?(new_resource.homebrew_path) }
  end

  file homebrew_uninstall do
    action :delete
  end
end

action_class do
  include HomebrewCookbook::Helpers
end
