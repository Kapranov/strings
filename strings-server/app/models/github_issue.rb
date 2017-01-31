class GithubIssue
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  field :login,               type: String,   required: true
  field :github_id,           type: Integer,  required: true
  field :avatar_url,          type: String,   required: true
  field :gravatar_id,         type: Integer,  required: false
  field :url,                 type: String,   required: true
  field :html_url,            type: String,   required: true
  field :followers_url,       type: String,   required: true
  field :following_url,       type: String,   required: true
  field :gists_url,           type: String,   required: true
  field :starred_url,         type: String,   required: true
  field :subscriptions_url,   type: String,   required: true
  field :organizations_url,   type: String,   required: true
  field :repos_url,           type: String,   required: true
  field :events_url,          type: String,   required: true
  field :received_events_url, type: String,   required: true
  field :type,                type: String,   required: true
  field :site_admin,          type: Boolean,  required: true
  field :name,                type: String,   required: true
  field :company,             type: String,   required: true
  field :blog,                type: String,   required: true
  field :location,            type: String,   required: true
  field :email,               type: String,   required: true
  field :hireable,            type: Boolean,  required: true
  field :bio,                 type: Text,     required: true
  field :public_repos,        type: Integer,  required: true
  field :public_gists,        type: Integer,  required: true
  field :followers,           type: Integer,  required: true
  field :following,           type: String,   required: true
  field :created_at,          type: Time,     required: true
  field :updated_at,          type: Time,     required: true

end
