# frozen_string_literal: true

title 'Default Tests'

control 'homebrew-install-01' do
  impact 1.0
  title 'Homebrew is installed'

  describe command('/bin/sh -c "PATH=/opt/homebrew/bin:/usr/local/bin:$PATH brew --version"') do
    its('stdout') { should match(/^Homebrew.*$/) }
  end

  brew_prefix = command('/bin/sh -c "PATH=/opt/homebrew/bin:/usr/local/bin:$PATH brew --prefix"').stdout.chomp

  describe brew_prefix do
    it { should match(%r{^(/usr/local|/opt/homebrew)$}) }
  end

  describe file(brew_prefix) do
    it { should be_directory }
  end
end

control 'homebrew-cask-01' do
  impact 1.0
  title 'Homebrew Cask is available'

  brew_caskroom = command('/bin/sh -c "PATH=/opt/homebrew/bin:/usr/local/bin:$PATH brew --caskroom"').stdout.chomp

  describe brew_caskroom do
    it { should match(%r{^(/usr/local|/opt/homebrew)/Caskroom$}) }
  end

  describe file(brew_caskroom) do
    it { should be_directory }
  end

  ci_user = command('whoami').stdout.chomp
  ci_user = command("/bin/sh -c 'echo $SUDO_USER'").stdout.chomp if ci_user == 'root'

  describe file("#{brew_caskroom}/caffeine") do
    it { should be_directory }
    its('mode') { should cmp '0755' }
    it { should be_owned_by ci_user }
  end
end

control 'homebrew-formula-01' do
  impact 1.0
  title 'Formulae are installed'

  describe package('redis') do
    it { should be_installed }
  end

  describe package('jq') do
    it { should be_installed }
  end
end
