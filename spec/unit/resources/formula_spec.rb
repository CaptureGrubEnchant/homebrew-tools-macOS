# frozen_string_literal: true

require 'spec_helper'

describe 'homebrew_formula' do
  step_into :homebrew_formula
  platform 'mac_os_x', '12'

  context 'with default properties' do
    recipe do
      homebrew_formula 'jq'
    end

    it { is_expected.to install_homebrew_package('jq') }
  end

  context 'with version and options' do
    recipe do
      homebrew_formula 'ruby' do
        version '3.4.0'
        options '--build-from-source'
        head true
      end
    end

    it do
      is_expected.to install_homebrew_package('ruby').with(
        version: '3.4.0',
        options: ['--build-from-source', '--HEAD']
      )
    end
  end

  context 'action :remove' do
    recipe do
      homebrew_formula 'jq' do
        action :remove
      end
    end

    it { is_expected.to remove_homebrew_package('jq') }
  end
end
