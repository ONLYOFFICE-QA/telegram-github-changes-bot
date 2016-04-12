require 'octokit'
require 'yaml'
config = YAML.load_file('config.yml')

Octokit.configure do |c|
  c.login = config['github_user']
  c.password = config['github_user_password']
end

def get_tag_names(repo)
  tags = []
  Octokit.tags(repo).each do |current_tag|
    tags << current_tag['name'] if current_tag['name'].include?('onlyoffice-documentserver')
  end
  tags
end

def get_changes_url(repo)
  new_tags = get_tag_names(repo)
  new_tag = new_tags[0]
  old_tag = new_tags[1]
  "[#{repo} changes](http://github.com/#{repo}/compare/#{old_tag}...#{new_tag})"
end
