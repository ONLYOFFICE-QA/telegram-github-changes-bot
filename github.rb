require 'octokit'

config = YAML.load_file('config.yml')

Octokit.configure do |c|
  c.login = config['github_user']
  c.password = config['github_user_password']
end

def get_tag_names(repo, tag_filter = '')
  tags = []
  Octokit.tags(repo).each do |current_tag|
    tags << current_tag['name'] if current_tag['name'].include?(tag_filter)
  end
  tags
end

def get_changes_url(repo)
  new_tags = get_tag_names(repo, 'onlyoffice-documentserver')
  @new_tag = new_tags[0]
  @old_tag = new_tags[1]
  "https://github.com/#{repo}/compare/#{@old_tag}...#{@new_tag}"
end

def changes_empty?(repo)
  changes = Octokit.compare(repo, @old_tag, @new_tag)
  changes[:files].empty?
end

def link_to_changes(repo)
  changes_url = get_changes_url(repo)
  return if changes_empty?(repo)
  "[#{repo} changes](#{changes_url})\n"
end
