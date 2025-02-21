# Change log

## Unreleased (master)

### New Features

* Use `ruby-3.4` as base for application
* New `/help` command with bot description
* Log any received command (known and unknown)
* Add 100% branch coverage check in ci
* Add `yamllint` check in CI
* Add `skip_if_refs_not_found` option for repo
* Mount `config.json` via volume in docker-compose
* Add `dependabot` check for Docker base image
* Add `hadolint` check in CI
* Build `onlyoffice/telegram-github-changes-bot` docker image
  in CI
* Add `faraday-retry` gem dependency, to fix warning
* Add `dependabot` check for `GitHub Actions`
* Use `vcr` gem in specs, greatly increase speed and relability

### Fixes

* Fix `markdownlint` failure because of old `nodejs` in CI
* Fix bot failure if received event is not a message
* Workaround a bug for failing build on arm64
* Run `rubocop` in CI through `bundle exec`

### Changes

* [ci] Increase order of `markdownlint` check for faster failures
* Increase branch coverage to 100%
* Remove `ruby-2.7`, `ruby-3.0`, `ruby-3.1`, `ruby-3.2` from CI since
  we use `ruby-3.3` in default docker
* Remove `codeclimate` support since we don't use it any more
* Check `dependabot` at 8:00 Moscow time daily
* Major refactoring in project structure
* Remove support of ENV variable for github access init
* Change config format to `json`
* Use docker hub image in default compose
* Add build packages to correctly install `bigdecimal` gem

## 1.0.0 (2021-01-22)

### New Features

* Add `ruby-3.0` to CI
* Add Docker build check in CI

### Changes

* Use `ruby:3.0-alpine` as default base image

### Fixes

* Fix `hadolint` DL3025 issue

## 0.3.0 (2020-12-21)

### New Features

* Add `dependabot` config
* Add `rubocop-rake` support

### Changes

* Allow failures on `ruby-head` in CI
* Fix new warnings from `rubocop` v0.93.0 update
* CI only on current stable ruby and ruby-head
* Remove support of `codecov`, use pure `simplecov`

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
* Force pagination - without it some data may be lost
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
