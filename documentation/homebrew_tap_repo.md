# homebrew_tap_repo

Adds or removes a Homebrew tap repository.

This resource intentionally uses `homebrew_tap_repo` instead of `homebrew_tap` to avoid colliding
with Chef Infra's built-in `homebrew_tap` resource.

## Actions

| Action | Description |
| --- | --- |
| `:tap` | Adds the tap. Default. |
| `:untap` | Removes the tap. |
| `:delete` | Removes the tap. |

## Properties

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| `tap_name` | String | name property | Tap name, such as `hashicorp/tap`. |
| `url` | String | unset | Optional Git URL for the tap. |
| `full` | true, false | `false` | Legacy compatibility property. Current Homebrew no longer supports full-clone taps, so this property is accepted but ignored. |
| `homebrew_path` | String | calculated | Path to the `brew` executable. |
| `owner` | String | calculated | User that owns the Homebrew installation. |

## Examples

### Basic tap

```ruby
homebrew_tap_repo 'hashicorp/tap'
```

### Tap from a URL

```ruby
homebrew_tap_repo 'hashicorp/tap' do
  url 'https://github.com/hashicorp/homebrew-tap.git'
end
```

### Remove a tap

```ruby
homebrew_tap_repo 'hashicorp/tap' do
  action :untap
end
```
