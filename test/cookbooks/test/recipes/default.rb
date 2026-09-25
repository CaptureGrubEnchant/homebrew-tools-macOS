# frozen_string_literal: true

ssh_known_hosts_entry 'github.com' do
  group 'wheel'
end

build_essential 'Install compilation tools'

homebrew_install 'default' do
  enable_analytics false
end

homebrew_formula 'redis'
homebrew_formula 'jq'

homebrew_tap_repo 'hashicorp/tap' do
  url 'https://github.com/hashicorp/homebrew-tap.git'
end

homebrew_cask_app 'caffeine'
