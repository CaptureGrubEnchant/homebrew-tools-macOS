# frozen_string_literal: true

provides :homebrew_formula
unified_mode true

property :formula_name, String, name_property: true
property :version, String
property :options, [String, Array], desired_state: false
property :head, [true, false], default: false, desired_state: false

default_action :install

action :install do
  homebrew_package new_resource.formula_name do
    version new_resource.version if new_resource.version
    options formula_options unless formula_options.empty?
    action :install
  end
end

action :remove do
  homebrew_package new_resource.formula_name do
    action :remove
  end
end

action_class do
  def formula_options
    options = Array(new_resource.options).join(' ')
    options = "#{options} --HEAD" if new_resource.head
    options.strip
  end
end
