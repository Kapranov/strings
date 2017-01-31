require 'json'
require 'rest-client'

class CreateGithubIssueService
  def call
    url = "https://api.github.com/users/"
    issues = [
      "kapranov",
      "wycats",
      "tomdale"
    ]
    issues.each do |issue|
      request = RestClient.get(url + issue, { params: {t: issue, r: :json}})
      issue_json = JSON.parse(request.body, object_class: OpenStruct)
      issue = GithubIssue.create!(
        login:                issue_json.login,
        github_id:            issue_json.id.to_i,
        avatar_url:           issue_json.avatar_url,
        gravatar_id:          issue_json.gravatar_id.to_i,
        url:                  issue_json.url,
        html_url:             issue_json.html_url,
        followers_url:        issue_json.followers_url,
        following_url:        issue_json.following_url,
        gists_url:            issue_json.gists_url,
        starred_url:          issue_json.starred_url,
        subscriptions_url:    issue_json.subscriptions_url,
        organizations_url:    issue_json.organizations_url,
        repos_url:            issue_json.repos_url,
        events_url:           issue_json.events_url,
        received_events_url:  issue_json.received_events_url,
        type:                 issue_json.type,
        site_admin:           issue_json.site_admin,
        name:                 issue_json.name,
        company:              issue_json.company,
        blog:                 issue_json.blog,
        location:             issue_json.location,
        email:                issue_json.email,
        hireable:             issue_json.hireable,
        bio:                  issue_json.bio,
        public_repos:         issue_json.public_repos,
        public_gists:         issue_json.public_gists,
        followers:            issue_json.followers,
        following:            issue_json.following,
        created_at:           issue_json.created_at,
        updated_at:           issue_json.updated_at
      )
      puts "Created Issue: #{GithubIssue.count}"
    end
    puts "--------------------------------------"
    puts " Created a total :#{GithubIssue.count}"
    puts "--------------------------------------"
  end
  puts "Destroy Issues: #{GithubIssue.count}"
end

