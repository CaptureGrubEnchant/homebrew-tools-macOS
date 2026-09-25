# frozen_string_literal: true

provides :homebrew_tap_repo
unified_mode true

use '_partial/_homebrew'

property :tap_name, String, name_property: true, regex: %r{^[\w-]+(?:\/[\w-]+)+$}
property :url, String
property :full, [true, false], default: false

default_action :tap

action :tap do
  execute "tap #{new_resource.tap_name}" do
    command lazy { tap_command }
    user new_resource.owner
    environment lazy { homebrew_user_environment(new_resource.owner) }
    cwd lazy { ::Dir.home(new_resource.owner) }
    not_if { tapped?(new_resource.tap_name) }
  end
end

action :untap do
  execute "untap #{new_resource.tap_name}" do
    command lazy { "#{new_resource.homebrew_path} untap #{new_resource.tap_name}" }
    user new_resource.owner
    environment lazy { homebrew_user_environment(new_resource.owner) }
    cwd lazy { ::Dir.home(new_resource.owner) }
    only_if { tapped?(new_resource.tap_name) }
  end
end

action :delete do
  execute "untap #{new_resource.tap_name}" do
    command lazy { "#{new_resource.homebrew_path} untap #{new_resource.tap_name}" }
    user new_resource.owner
    environment lazy { homebrew_user_environment(new_resource.owner) }
    cwd lazy { ::Dir.home(new_resource.owner) }
    only_if { tapped?(new_resource.tap_name) }
  end
end

action_class do
  include HomebrewCookbook::Helpers

  def tap_command
    [
      new_resource.homebrew_path,
      'tap',
      new_resource.tap_name,
      new_resource.url,
    ].compact.reject(&:empty?).join(' ')
  end
end
