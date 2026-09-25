# homebrew_formula

Installs or removes a Homebrew formula using Chef's Homebrew package resource.

## Actions

| Action | Description |
| --- | --- |
| `:install` | Installs the formula. Default. |
| `:remove` | Removes the formula. |

## Properties

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| `formula_name` | String | name property | Formula name. |
| `version` | String | unset | Optional formula version. |
| `options` | String, Array | unset | Extra install options. |
| `head` | true, false | `false` | Adds `--HEAD` to install options. |

## Examples

### Basic install

```ruby
homebrew_formula 'jq'
```

### Versioned install with options

```ruby
homebrew_formula 'ruby' do
  version '3.4.0'
  options '--build-from-source'
end
```

### Remove a formula

```ruby
homebrew_formula 'jq' do
  action :remove
end
```
