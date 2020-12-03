# Change log

## Unreleased (master)

### New Features

* Add `dependabot` config

### Changes

* Allow failures on `ruby-head` in CI
* Fix new warnings from `rubocop` v0.93.0 update
* CI only on current stable ruby and ruby-head

## 0.2.0 (2020-08-31)

### Changes

* Send message in `html` parse mode
* Drop support of ruby 2.4, since it's EOLed

## 0.1.0 (2020-08-12)

### New Features

* Show version number in changes link
* Ability to get changes from specific version: ask `/get_changes 3.8.0-208`
* Move setting tag filter to config file
* More string checking for filter tags, after tags filter should be version numbers
* Move regexp for version to config file
* Some refactor
* Correctly ignore Telegram 502 error
* Major refactor in handling repo refs
* Use `refs` instead of `tags`
* Show more detailed message if specified ref - is the latest
* Force pagination - without it some data meay be lost
* Do not install test gems in dockerfile
* Add logging of fetching changes
* Fix new warnings from `rubocop` v0.89.0 update
* Support of `markdownlint` in travis-ci
* Increase test coverage to 100%
* Add option to `GithubRepoChanges.new` to force read config from file
* Increase documentation to 100%
* Use `GitHub Actions` instead of `Travis CI`
* Add `yard` as dev dependency

### Fixes

* Fix warning for `bundle install` (user `bundle config set without`)

### Changes

* Use `alpine` as base image
* `GITHUB_USER_NAME` and `GITHUB_USER_PASSWORD` changed
  to `CHANGES_BOT_GH_USER` nad `CHANGES_BOT_GH_PASS`
* Remove unused `version_regex` attr_reader

## 0.0.2

### New Features

* Show only repos with new changes

## 0.0.1

* Initial Release
