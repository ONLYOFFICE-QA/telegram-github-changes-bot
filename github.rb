require 'octokit'
require 'yaml'

# Class for describing changes for github repo
class GithubRepoChanges
  def initialize(config_file: 'config.yml',
                 repo: nil,
                 tags_filter: 'onlyoffice-documentserver')
    @config = YAML.load_file(config_file)
    @repo = repo
    @tags_filter = tags_filter
    Octokit.configure do |c|
      c.login = @config['github_user']
      c.password = @config['github_user_password']
    end
  end

  def tag_names(tag_filter = '')
    tags = []
    Octokit.tags(@repo).each do |current_tag|
      tags << current_tag['name'] if current_tag['name'].include?(tag_filter)
    end
    tags
  end

  def fetch_latest_tags
    tags = tag_names(@tags_filter)
    @new_tag = tags[0]
    @old_tag = tags[1]
  end

  def changes_url
    "https://github.com/#{@repo}/compare/#{@old_tag}...#{@new_tag}"
  end

  def changes_empty?
    changes = Octokit.compare(@repo, @old_tag, @new_tag)
    changes[:files].empty?
  end

  def link_to_changes
    fetch_latest_tags
    return '' if changes_empty?
    "[#{@repo} changes](#{changes_url})\n"
  end
end
