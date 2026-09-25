# homebrew_cask_app

Installs or removes a Homebrew cask application.

This resource intentionally uses `homebrew_cask_app` instead of `homebrew_cask` to avoid colliding
with Chef Infra's built-in `homebrew_cask` resource.

## Actions

| Action | Description |
| --- | --- |
| `:install` | Installs the cask. Default. |
| `:remove` | Removes the cask. |

## Properties

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| `cask_name` | String | name property | Cask name. |
| `options` | String | unset | Extra options passed to `brew install --cask`. |
| `install_cask` | true, false | `true` | Whether to tap `homebrew/cask` before managing the cask. |
| `homebrew_path` | String | calculated | Path to the `brew` executable. |
| `owner` | String | calculated | User that owns the Homebrew installation. |

## Examples

### Basic install

```ruby
homebrew_cask_app 'caffeine'
```

### Install with options

```ruby
homebrew_cask_app 'google-chrome' do
  options '--appdir=/Applications'
end
```

### Remove a cask

```ruby
homebrew_cask_app 'caffeine' do
  action :remove
end
```
