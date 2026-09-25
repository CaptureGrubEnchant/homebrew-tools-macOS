# frozen_string_literal: true

property :homebrew_path, String, default: lazy { "#{HomebrewWrapper.new.install_path}/bin/brew" }
property :owner, String, default: lazy { HomebrewWrapper.new.owner }
