require 'json'
require 'rest-client'

url = "https://api.github.com/users/"
issues = [ "kapranov", "wycats", "tomdale" ]
issues.each do |issue|
  request = RestClient.get(url + issue, { params: {t: issue, r: :json}})
  issue_json = JSON.parse(request.body, object_class: OpenStruct)
  puts "------------- GithubIssue ---------------"
  puts "Login: #{issue_json.login}"
  puts "Id: #{issue_json.id.to_i}"
  puts "#{issue_json.avatar_url}"
  puts "#{issue_json.gravatar_id.to_i}"
  puts "#{issue_json.url}"
  puts "#{issue_json.html_url}"
  puts "#{issue_json.followers_url}"
  puts "#{issue_json.following_url}"
  puts "#{issue_json.gists_url}"
  puts "#{issue_json.starred_url}"
  puts "#{issue_json.subscriptions_url}"
  puts "#{issue_json.organizations_url}"
  puts "#{issue_json.repos_url}"
  puts "#{issue_json.events_url}"
  puts "#{issue_json.received_events_url}"
  puts "#{issue_json.type}"
  puts "#{issue_json.site_admin}"
  puts "#{issue_json.name}"
  puts "#{issue_json.company}"
  puts "#{issue_json.blog}"
  puts "#{issue_json.location}"
  puts "#{issue_json.email}"
  puts "#{issue_json.hireable}"
  puts "#{issue_json.bio}"
  puts "#{issue_json.public_repos}"
  puts "#{issue_json.public_gists}"
  puts "#{issue_json.followers}"
  puts "#{issue_json.following}"
  puts "#{issue_json.created_at}"
  puts "#{issue_json.updated_at}"
  puts "----------------- End -------------------\n\n"
end
