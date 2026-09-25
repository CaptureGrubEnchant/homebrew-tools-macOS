# frozen_string_literal: true

provides :homebrew_cask_app
unified_mode true

use '_partial/_homebrew'

property :cask_name, String, regex: %r{^[\w/-]+$}, name_property: true
property :options, String
property :install_cask, [true, false], default: true

default_action :install

action :install do
  homebrew_tap_repo 'homebrew/cask' if new_resource.install_cask

  execute "install cask #{new_resource.cask_name}" do
    command lazy { cask_install_command }
    user new_resource.owner
    environment lazy { homebrew_user_environment(new_resource.owner) }
    cwd lazy { ::Dir.home(new_resource.owner) }
    not_if { casked?(new_resource.homebrew_path, new_resource.cask_name) }
  end
end

action :remove do
  homebrew_tap_repo 'homebrew/cask' if new_resource.install_cask

  execute "remove cask #{new_resource.cask_name}" do
    command lazy { "#{new_resource.homebrew_path} uninstall --cask #{new_resource.cask_name}" }
    user new_resource.owner
    environment lazy { homebrew_user_environment(new_resource.owner) }
    cwd lazy { ::Dir.home(new_resource.owner) }
    only_if { casked?(new_resource.homebrew_path, new_resource.cask_name) }
  end
end

action_class do
  include HomebrewCookbook::Helpers

  def cask_install_command
    [
      new_resource.homebrew_path,
      'install',
      '--cask',
      new_resource.cask_name,
      new_resource.options,
    ].compact.reject(&:empty?).join(' ')
  end
end
