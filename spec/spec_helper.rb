# frozen_string_literal: true

require 'chefspec'
require 'chefspec/policyfile'

require_relative '../libraries/helpers'

RSpec.configure do |config|
  config.color = true               # Use color in STDOUT
  config.formatter = :documentation # Use the specified formatter
  config.log_level = :error         # Avoid deprecation notice SPAM
end
