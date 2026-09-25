# Migration

This release is a full custom resource migration. The cookbook no longer provides recipes or
attributes. Replace run-list entries and `node['homebrew']` attributes with explicit resource
declarations.

## Removed Recipes

| Removed recipe | Replacement |
| --- | --- |
| `homebrew::default` | `homebrew_install` |
| `homebrew::install_formulas` | One `homebrew_formula` resource per formula |
| `homebrew::install_taps` | One `homebrew_tap_repo` resource per tap |
| `homebrew::install_casks` | One `homebrew_cask_app` resource per cask |
| `homebrew::cask` | `homebrew_cask_app` handles the tap when `install_cask true` |

## Removed Attributes

| Removed attribute | Replacement property |
| --- | --- |
| `node['homebrew']['owner']` | `owner` on resources that execute `brew` |
| `node['homebrew']['auto-update']` | `auto_update` on `homebrew_install` |
| `node['homebrew']['enable-analytics']` | `enable_analytics` on `homebrew_install` |
| `node['homebrew']['installer']['url']` | `installer_url` on `homebrew_install` |
| `node['homebrew']['installer']['checksum']` | `installer_checksum` on `homebrew_install` |
| `node['homebrew']['formulas']` | `homebrew_formula` declarations |
| `node['homebrew']['taps']` | `homebrew_tap_repo` declarations |
| `node['homebrew']['casks']` | `homebrew_cask_app` declarations |

## Before

```ruby
node.default['homebrew']['enable-analytics'] = false
node.default['homebrew']['formulas'] = %w(redis jq)
node.default['homebrew']['casks'] = %w(caffeine)
node.default['homebrew']['taps'] = [
  { 'tap' => 'hashicorp/tap', 'url' => 'https://github.com/hashicorp/homebrew-tap.git' },
]

include_recipe 'homebrew::install_formulas'
include_recipe 'homebrew::install_casks'
include_recipe 'homebrew::install_taps'
```

## After

```ruby
homebrew_install 'default' do
  enable_analytics false
end

homebrew_formula 'redis'
homebrew_formula 'jq'

homebrew_tap_repo 'hashicorp/tap' do
  url 'https://github.com/hashicorp/homebrew-tap.git'
end

homebrew_cask_app 'caffeine'
```

Legacy `full` tap values are accepted by `homebrew_tap_repo`, but current Homebrew no longer
supports full-clone taps and the property is ignored.

## Built-in Chef Resource Name Collisions

Chef Infra already includes `homebrew_tap` and `homebrew_cask`. This cookbook uses
`homebrew_tap_repo` and `homebrew_cask_app` for its custom resources so Chef can resolve the
resource names unambiguously on modern Chef Infra Client versions.
