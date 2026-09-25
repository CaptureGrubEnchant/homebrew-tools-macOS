# homebrew Cookbook CHANGELOG

This file is used to list changes made in each version of the homebrew cookbook.

Standardise files with files in sous-chefs/repo-management
Standardise files with files in sous-chefs/repo-management

## [7.0.0](https://github.com/sous-chefs/homebrew/compare/v6.0.3...v7.0.0) (2026-06-02)


### ⚠ BREAKING CHANGES

* migrate homebrew to resources ([#210](https://github.com/sous-chefs/homebrew/issues/210))

### Features

* migrate homebrew to resources ([#210](https://github.com/sous-chefs/homebrew/issues/210)) ([e80f4a2](https://github.com/sous-chefs/homebrew/commit/e80f4a26088c386772a0f7e567756a3573aa823e))


### Bug Fixes

* **ci:** Update workflows to use release pipeline ([#204](https://github.com/sous-chefs/homebrew/issues/204)) ([a5142fc](https://github.com/sous-chefs/homebrew/commit/a5142fc44a421736ca08a5316a9a42b494491b3b))

## [6.0.3](https://github.com/sous-chefs/homebrew/compare/6.0.2...v6.0.3) (2025-10-16)


### Bug Fixes

* **ci:** Update workflows to use release pipeline ([#204](https://github.com/sous-chefs/homebrew/issues/204)) ([a5142fc](https://github.com/sous-chefs/homebrew/commit/a5142fc44a421736ca08a5316a9a42b494491b3b))

## 6.0.2 - *2025-09-04*

Standardise files with files in sous-chefs/repo-management

Standardise files with files in sous-chefs/repo-management

## 6.0.0 - *2025-03-17*

* Updated library call for new homebrew class name found in chef-client 18.6.2+ releases

## 5.4.9 - *2024-11-18*

Standardise files with files in sous-chefs/repo-management

Standardise files with files in sous-chefs/repo-management

Standardise files with files in sous-chefs/repo-management

Standardise files with files in sous-chefs/repo-management

Standardise files with files in sous-chefs/repo-management

## 5.4.7 - *2024-05-06*

* Explicitly include `Which` module from `Chef` which fixes runs on 18.x clients.

## 5.4.5 - *2023-11-01*

Standardise files with files in sous-chefs/repo-management

## 5.4.0 - *2023-04-24*

* Add temporary sudoers entry to fix homebrew installation

## 5.3.8 - *2023-04-16*

Standardise files with files in sous-chefs/repo-management

## 5.3.7 - *2023-04-04*

* Sous Chefs adoption
* Update lint-unit workflow to 2.0.2
* Set unified_mode for all resources
  * Require Chef 15.3+ for unified_mode
* Standardise files with files in sous-chefs/repo-management

## 5.3.6 - *2023-04-01*

* Standardise files with files in sous-chefs/repo-management

## 5.3.5 - *2023-03-02*

* Standardise files with files in sous-chefs/repo-management

## 5.3.4 - *2023-02-20*

* Standardise files with files in sous-chefs/repo-management

## 5.3.4 - *2023-02-20*

* Standardise files with files in sous-chefs/repo-management

## 5.3.3 - *2023-02-14*

* Standardise files with files in sous-chefs/repo-management

## 5.3.2 - *2022-12-15*

* Standardise files with files in sous-chefs/repo-management
* Fix workflow CI

## 5.3.1 - *2022-02-10*

* Standardise files with files in sous-chefs/repo-management
* Remove delivery folder

## 5.3.0 - *2021-12-21*

* Update to support Apple M1 silicon (arm64) Homebrew install location (`/opt/homebrew`)
   * Add HomebrewWrapper.repository_path() for homebrew_tap resource idempotency
   * Add HomebrewWrapper.repository_path() helper for Apple M1 silicon (arm64)
   * Remove deprecated `--full` option for Homebrew (Breaking upstream CLI change!)
   * Add chefspec tests for Apple M1 silicon Homebrew path helper
   * Add InSpec tests for macOS M1 / arm64 and x86_64
   * Set `use_sudo: false` for InSpec tests to work properly
   * Convert hardcoded /usr/local to use install_path() for M1 /opt/homebrew support
   * Add Homebrew.install_path() helper for Apple M1 silicon (arm64)

## 5.2.2 - *2021-08-30*

* Standardise files with files in sous-chefs/repo-management

## 5.2.1 - *2021-06-01*

* Standardise files with files in sous-chefs/repo-management

## 5.2.0 - *2021-01-24*

* Sous Chefs Adoption
* Standardise files with files in sous-chefs/repo-management

## 5.1.1 (2021-01-04)

* Update to use --cask instead of cask command for compatibility with newer homebrew releases- [@tas50](https://github.com/tas50)
* resolved cookstyle error: resources/cask.rb:23:1 warning: `ChefDeprecations/ResourceUsesOnlyResourceName`
* resolved cookstyle error: resources/tap.rb:23:1 warning: `ChefDeprecations/ResourceUsesOnlyResourceName`

## 5.1.0 (2020-05-15)

* Rename the kitchen config - [@tas50](https://github.com/tas50)
* Cookstyle fixes - [@tas50](https://github.com/tas50)
* OS X -> macOS in the readme - [@tas50](https://github.com/tas50)
* Require Chef 12.15+ - [@tas50](https://github.com/tas50)
* Update default install script from ruby to bash - [@bbros-dev](https://github.com/bbros-dev)
* Resole chefspec failures - [@tas50](https://github.com/tas50)

## 5.0.8 (2018-10-04)

* Updates homebrew cask tap to homebrew/cask
* Updates URLs to the homebrew cask repository

## 5.0.7 (2018-09-26)

* Fix cask resource running each chef-client run

## 5.0.6 (2018-09-26)

* Avoid CHEF-25 Deprecation warnings by making the tap/cask resources no-ops on modern chef-client releases

## 5.0.5 (2018-09-04)

* Update name of macos in kitchen config
* Add deprecation notice for the homebrew_tap and homebrew_cask resources. These resources are now built into Chef 14 and they will be removed from this cookbook when Chef 13 goes EOL, April 2019.

## 5.0.4 (2018-03-16)

* Fix backwards logic in the cask install action

## 5.0.3 (2018-03-09)

* Resolve method missing errors in the library

## 5.0.2 (2018-03-09)

* Remove some legacy logic around the Chef Homebrew user module
* Use lazy to prevent compilation failures on non-macOS platforms

## 5.0.1 (2018-03-08)

* Added a cask_name and tap_name property to the cask/tap resources. These are name_properties which allow you to set the tap/cask name to something other than the resources name. Handy for avoiding resource cloning.

## 5.0.0 (2018-03-08)

* Added a new homebrew_path property to cask/tap for the homebrew binary
* Added a new owner property to cash/tap for setting the homebrew owner
* Converted execute resources in the resources to converge_by and shellout to provide better converge messaging in line with other core Chef resources=
* Renamed the :uninstall action in the cask resource to :remove. This aligns with other chef package resources. The previous action will continue to function.
* Fully documented the resource actions and properties in the readme
* Removed deprecated taps out of the test recipe
* Removed the ChefSpec matchers that are now autogenerated by ChefSpec in modern releases of ChefDK. If this causes failures you need to upgrade ChefDK

## 4.3.0 (2018-01-13)

* Allow Cask name to be scoped to tap
* Disable Foodcrtiic's FC108 since it doesn't apply here
* Automatically install caskroom/cask in the cask resource. This eliminates the need for the cask recipe.
* Resolve Chef 14 deprecation warnings

## 4.2.2 (2018-01-13)

* Fix failures in the cask resource
* Improve inspec output for file mode test

## 4.2.1 (2018-01-13)

* Remove double shellout from a bad merge
* Test on modern macOS releases
* Use full file modes throughout the recipes
* Add 2 retries for downloading the homebrew script in case it fails

## 4.2.0 (2017-05-30)

* Remove class_eval and require Chef 12.7+

## 4.1.0 (2017-04-25)

* Extend the tap resource to use the --full option. See the readme for details and examples

## 4.0.0 (2017-04-19)

* Convert the tap and cask resources from LWRPs to custom resources which simplifies the code and fixes an incompatibility with Chef 13
* Uses the homebrew_owner as the user to check if a cask has been casked
* Fixed the location of the tap dir to properly prevent trying to install a tap twice
* Refactor the mixin to be a simpler helper that is easier to test
* Resolved failures in the Chefspecs on Travis
* Test with Local Delivery and not Rake
* Use standardize Apache 2 license string
* Only check if homebrew exists once in the default recipe

## 3.0.0 (2016-12-19)

* The homebrew package provider has been removed from this cookbook. It ships with Chef 12.0+. This cookbook now requires a minimum of Chef 12.1 or later.
* This cookbook no longer depends on build-essential as it wasn't using it directly
* Properly define the chefspec matchers
* Add chef_version metadata and remove OS X server which isn't an actual platform from ohai
* Don't grab homebrew_go script if homebrew is already installed.
* Add ability to disable sending analytics data via a new attribute
* Move testing to a test cookbook to make it easier to expand in the future. Also convert integration tests to InSpec from ServerSpec

## 2.1.2 (2016-09-07)

* Allow passing custom options to brew packages

## 2.1.1 (2016-09-06)

* Run chefspecs as OS X
* Update cask recipe to not create /opt/homebrew-cask and /opt/homebrew-cask/Caskroom
* Update tests

## v2.1.0 (2016-03-29)

* Make homebrew install script url configurable
* Make package_info more efficient

## v2.0.5 (2016-01-25)

* Updated execute resources to pass in the HOME/USER environmental variables so homebrew commands are properly executed
* Removed redundant code from recipes and providers
* Removed brew-cask installation and the upgade execute that are no longer necessary
* Added directory creation of /Library/Caches/Homebrew/Casks in case it's not present
* Updated creation of /opt/homebrew-cask to be recursive in case /opt hasn't been created yet

## v2.0.4 (2016-01-20)

* Use the officially supported method of querying homebrew data vs. unsupported internal APIs
* Fixed environmental variables in the homebrew command execution

## v2.0.3 (2015-12-09)

* Fixed poor name matching in determining if a cask had been installed already, which prevented some casks from installing

## v2.0.2 (2015-12-04)

* Prevents casks from installing on every chef run

## v2.0.1 (2015-12-03)

* Fixed already-installed casks breaking builds

## v2.0.0 (2015-12-01)

* Removed all Chef 10 compatibility code
* 77 Update the tap provider to properly notify on changes
* 73 Allow specifying versions (or HEAD) of formulas (see readme for usage)
* Updated contributing, testing, and maintainers docs
* Updated contents of chefignore and .gitignore files
* Updated development dependencies in the Gemfile
* Added Travis CI and supermarket version badges to the readme
* Added Chef standard rubocop file and resolved all warnings
* Added super metadata for Supermarket
* Added testing in Travis CI
* 75 Fix Chefspecs to properly run on Linux hosts (like Travis)
* Add Rakefile for simplified testing
* Resolved all foodcritic warnings

## v1.13.0 (2015-06-23)

* 72 Massage Chef12HomebrewUser.find_homebrew_uid into username
* 69 Add options to cask

## v1.12.0 (2015-01-29)

* 67 Add attribute and recipe for installing homebrew taps

## v1.11.0 (2015-01-12)

* 59 Update Homebrew Cask if auto-update attribute is true
* 52 Manage Homebrew Cask's install directories
* 56 Fix check for existing casks
* 61 Fix owner class for Chef 12
* Depend on build-essential cookbook 2.1.2+ to support OS X 10.10
* 64, #66 add and fix ChefSpec tests for default recipe

## v1.10.0 (2014-12-09)

* 55 This cookbook no longer sets its `homebrew_package` as the
* `package` provider for OS X when running under Chef 12
* List CHEF as the maintainer instead of Chef.

## v1.9.2 (2014-10-09)

Bug Fixes:

* 57 Update url per homebrew error: Upstream, the homebrew project
* has changed the URL for the installation script. All users of this
* cookbook are advised to update to this version.

## v1.9.0 (2014-07-29)

Improvements:

* 35 Modernize the cask provider (use why run mode, inline resources)
* 43 Use `brew cask list` to determine if casks are installed
* 45 Add `default_action` and print warning messages on earlier
* versions of Chef (10.10)

New Features:

* 44 Add `:install` and `:uninstall` actions and alias previous `:cask`,
* `:uncask` actions to them

Bug Fixes:

* 27 Fix name for taps adding the `/homebrew` prefix
* 28 Set `RUBYOPT` to `nil` so Chef can execute in a bundle (bundler
* sets `RUBYOPT` and this can cause issues when running the
* underlying `brew` commands)
* 40 Fix regex for cask to match current homebrew conventions
* 42 Fix attribute for list of formulas to match the README and
* maintain backward compat for 6 day old version

## v1.8.0 (2014-07-23)

* Add recipes to install an array of formulas/casks

## v1.7.2 (2014-06-26)

* Implement attribute to control auto-update

## v1.7.0 (2014-06-26)

* Add homebrew::cask recipe (#38)

## v1.6.6 (2014-05-29)

* [COOK-3283] Use homebrew_owner for cask and tap
* [COOK-4670] homebrew_tap provider is not idempotent
* [COOK-4671] Syntax Error in README

## v1.6.4 (2014-05-08)

* Fixing cask provider correctly this time. "brew cask list"

## v1.6.2 (2014-05-08)

* Fixing typo in cask provider: 's/brew brew/brew/'

## v1.6.0 (2014-04-23)

* [COOK-3960] Added LWRP for brew cask
* [COOK-4508] Add ChefSpec matchers for homebrew_tap
* [COOK-4566] Guard against "HEAD only" formulae

## v1.5.4

* [COOK-4023] Fix installer script's URL.
* Fixing up style for rubocop

## v1.5.2

* [COOK-3825] setting $HOME on homebrew_package

## v1.5.0

### Bug

* [COOK-3589] - Add homebrew as the default package manager on OS X Server

## v1.4.0

### Bug

* [COOK-3283] - Support running homebrew cookbook as root user, with sudo, or a non-privileged user

## v1.3.2

* [COOK-1793] - use homebrew "go" script to install homebrew
* [COOK-1821] - Discovered version using Homebrew Formula factory fails check that verifies that version is a String
* [COOK-1843] - Homebrew README.md contains non-ASCII characters, triggering same issue as COOK-522

## v1.3.0

* [COOK-1425] - use new json output format for formula
* [COOK-1578] - Use shell_out! instead of popen4

## v1.2.0

Chef Software has taken maintenance of this cookbook as the original author has other commitments. This is the initial release with Chef Software as maintainer.

Changes in this release:

* [pull/2] - support for option passing to brew
* [pull/3] - add brew upgrade and control return value from command
* [pull/9] - added LWRP for "brew tap"
* README is now markdown, not rdoc.
