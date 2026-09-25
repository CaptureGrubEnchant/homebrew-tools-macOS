# frozen_string_literal: true

class HomebrewUserWrapper
  require 'chef/mixin/homebrew'
  include Chef::Mixin::Homebrew
  include Chef::Mixin::Which
end

module HomebrewCookbook
  module Helpers
    def install_path
      macos_arm64? ? '/opt/homebrew' : '/usr/local'
    end

    def repository_path
      macos_arm64? ? '/opt/homebrew' : '/usr/local/Homebrew'
    end

    def homebrew_exists?(homebrew_path = "#{install_path}/bin/brew")
      Chef::Log.debug('Checking to see if the homebrew binary exists')
      ::File.exist?(homebrew_path)
    end

    def owner
      @owner ||= begin
                   HomebrewUserWrapper.new.find_homebrew_username
                 rescue
                   Chef::Exceptions::CannotDetermineHomebrewPath
                 end.tap do |homebrew_owner|
                   Chef::Log.debug("Homebrew owner is #{homebrew_owner}")
                 end
    end

    def homebrew_user_environment(homebrew_owner)
      { 'HOME' => ::Dir.home(homebrew_owner), 'USER' => homebrew_owner }
    end

    def homebrew_analytics_enabled?(homebrew_path, homebrew_owner)
      shell_out("#{homebrew_path} analytics state", user: homebrew_owner).stdout.include?('enabled')
    end

    def tap_directory(tap_name)
      tap_name.gsub('/', '/homebrew-')
    end

    def tapped?(tap_name)
      ::File.directory?("#{HomebrewWrapper.new.repository_path}/Library/Taps/#{tap_directory(tap_name)}")
    end

    def cask_directory(homebrew_path, cask_name)
      homebrew_prefix = ::File.dirname(::File.dirname(homebrew_path))
      ::File.join(homebrew_prefix, 'Caskroom', cask_name.split('/').last)
    end

    def casked?(homebrew_path, cask_name)
      ::File.directory?(cask_directory(homebrew_path, cask_name))
    end

    private

    def macos_arm64?
      shell_out('sysctl -n hw.optional.arm64').stdout.chomp == '1'
    end
  end
end

class HomebrewWrapper
  require 'chef/mixin/shell_out'
  include Chef::Mixin::ShellOut
  include HomebrewCookbook::Helpers
end
