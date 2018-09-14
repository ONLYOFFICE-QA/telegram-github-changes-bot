# Change log

## Unreleased (master)

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

## 0.0.2

### New Features

* Show only repos with new changes

## 0.0.1

* Initial Release