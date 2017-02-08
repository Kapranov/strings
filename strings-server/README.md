> Authenticating Your API

```
curl -H "Authorization: Token token=PsmmvKBqQDOaWwEsPpOCYMsy" http://localhost:3000/users
```

```
bash> rails g scaffold user name email
bash> rails g serializer user

class ApplicationController < ActionController::API
  include ActionController::Serialization
end

# GET http://api.mysite.com/v1/users/

# app/controllers/
# |-- api
# |   `-- v1
# |       |-- api_controller.rb
# |       `-- users_controller.rb
# |-- application_controller.rb

# app/controllers/api/v1/api_controller.rb
module Api::V1
  class ApiController < ApplicationController
    # Generic API stuff here
  end
end

# app/controllers/api/v1/users_controller.rb
module Api::V1
  class UsersController < ApiController
    def index
      render json: User.all
    end
  end
end

# config/routes.rb
constraints subdomain: 'api' do
  scope module: 'api' do
    namespace :v1 do
      resources :users
    end
  end
end

# Authorization: Token token="WCZZYjnOQFUYfJIN2ShH1iD24UHo58A6TI"

bash> rails g migration AddApiKeyToUsers api_key:string

class User < ActiveRecord::Base
  before_create do |user|
    user.api_key = user.generate_api_key
  end
end

# Generate a unique API key
def generate_api_key
  loop do
    token = SecureRandom.base64.tr('+/=', 'Qrt')
    break token unless User.exists?(api_key: token)
  end
end

class ApplicationController < ActionController::Base
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate

  protected
  def authenticate
    authenticate_token || render_unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |token, options|
      @current_user = User.find_by(api_key: token)
    end
  end

  def render_unauthorized(realm = "Application")
    self.headers["WWW-Authenticate"] = %(Token realm="#{realm.gsub(/"/, "")}")
    render json: 'Bad credentials', status: :unauthorized
  end
end

curl -H "Authorization: Token token=PsmmvKBqQDOaWwEsPpOCYMsy" http://localhost:3000/users
```

> Using RSpec for Testing

```ruby
rails g rspec:install
```

> For clearance install Sidekiq without info wars

``Unresolved specs during Gem::Specification.reset``

I was seeing this issue by just running RSpec on its own. From what I
understand, this means that you have more than one version of the listed
gems installed on your system, and RSpec is unsure which to use. After
uninstalling older version of the gems, the warnings went away.

```
bash> bundle clean --force
bash> gem install bigdecimal
bash> gem install json -v '2.0.2'
```

```ruby
# config/initializers/sidekiq.rb
Sidekiq.configure_server do |config|
  config.redis = { url: Rails.application.secrets.redis_url, :namespace => 'sidekiq' }
end
Sidekiq.configure_client do |config|
  config.redis = { url: Rails.application.secrets.redis_url, :namespace => 'sidekiq' }
end
```

```
# routing_test.rb
it "routes to #index" do
  expect(get: "/comments").to route_to("comments#index")
end

# request_test.rb
it "won't work without authentication" do
  get comments_path
  expect(response.status).to be(401)
end

it "will work with authentication" do
  get comments_path, {}, valid_session
  expect(response.status).to be(200)
end

# model_test.rb
it "should have errors if created with no user or post id" do
  comment = Comment.create
  expect(comment.save).to eq(false)
  expect(comment.errors.messages).to have_key(:user)
  expect(comment.errors.messages).to have_key(:post)
end

# controller_tests.rb
RSpec.describe CommentsController, type: :controller do
  describe "GET show" do
    it "assigns the requested comment as @comment" do
      comment = Comment.create! valid_attributes
      get :show, {id: comment.to_param}, valid_session
      expect(assigns(:comment)).to eq(comment)
    end
  end
end

describe "POST create" do
  it "creates a new Comment" do
    expect {
      post :create, valid_attributes, valid_session
    }.to change(Comment, :count).by(1)
  end
end
```

> REST Client

[https://github.com/rest-client/rest-client](REST Client Ruby)


```
require 'rest_client'

curl http://localhost:3000/ -H 'Authorization: Bearer access_token'
RestClient.get 'http://localhost:3000/' , {:Authorization => 'Bearer secret'}

response = RestClient.get("http://localhost:3000/users")
response = RestClient.get("http://localhost:3000/users", :accept => :json)
```

> Makes it dead easy to do HTTP Basic authentication.

```ruby
class UsersController < ApplicationController
  http_basic_authenticate_with name: "dhh", password: "secret", except: :index

  def index
    render plain: "Everyone can see me!"
  end

  def edit
    render plain: "I'm only accessible if you know the password"
  end
end
```

> Crafting APIs With Rails

[https://github.com/bodrovis/TutsPlusSource/tree/master/Rails_API](Source code)


```ruby
# controllers/api/v1/users_controller.rb
def index
  @users = User.order('created_at DESC')
  render json: @users
end

rails g migration add_token_to_users token:string:index

#db/migrate/xyz_add_token_to_users.rb
add_index :users, :token, unique: true

# models/user.rb
before_create -> {self.token = generate_token}

private
def generate_token
  loop do
    token = SecureRandom.hex
    return token unless User.exists?({token: token})
  end
end

# api_client.rb

require 'faraday'
require 'oj'

client = Faraday.new(url: 'http://localhost:3000') do |config|
  config.adapter  Faraday.default_adapter
end

response = client.post do |req|
  req.url '/api/v1/users'
  req.headers['Content-Type'] = 'application/json'
  req.body = '{ "user": {"name": "test user"} }'
end

puts Oj.load(response.body)
puts response.status

# controllers/api/v1/posts_controller.rb
class PostsController < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods
end

# controllers/api/v1/posts_controller.rb
before_action :authenticate, only: [:create, :destroy]

private

def authenticate
  authenticate_or_request_with_http_token do |token, options|
    @user = User.find_by(token: token)
  end
end

# controllers/api/v1/posts_controller.rb
def create
  @post = @user.posts.new(post_params)
  if @post.save
    render json: @post, status: :created
  else
    render json: @post.errors, status: :unprocessable_entity
  end
end

# api_client.rb
client = Faraday.new(url: 'http://localhost:3000') do |config|
  config.adapter  Faraday.default_adapter
  config.token_auth('127a74dbec6f156401b236d6cb32db0d')
end

response = client.post do |req|
  req.url '/api/v1/posts'
  req.headers['Content-Type'] = 'application/json'
  req.body = '{ "post": {"title": "Title", "body": "Text"} }'
end

# controllers/api/v1/posts_controller.rb
def destroy
  @post = @user.posts.find_by(params[:id])
  if @post
    @post.destroy
  else
    render json: {post: "not found"}, status: :not_found
  end
end

# api_client.rb
response = client.delete do |req|
  req.url '/api/v1/posts/6'
  req.headers['Content-Type'] = 'appli
end

# app/controllers/application_controller.rb
def token
  authenticate_with_http_basic do |email, password|
    user = User.find_by(email: email)
    if user && user.password == password
      render json: { token: user.auth_token }
    else
      render json: { error: 'Incorrect credentials' }, status: 401
    end
  end
end

# app/models/user.rb
before_create -> { self.auth_token = SecureRandom.hex }

curl http://localhost:3000/token -H 'Authorization: Basic dXNlckBleGFtcGxlLmNvbTpwYXNzd29yZA==\n'

# Second Handling Every Other Request
curl http://localhost:3000/posts/1 -H 'Authorization: Token token=861af99a9dbf5e052b8b55cfc41e69d7'

# app/controllers/application_controller.rb
before_filter :authenticate_user_from_token, except: [:token]

private
def authenticate_user_from_token
  unless authenticate_with_http_token { |token, options| User.find_by(auth_token: token) }
    render json: { error: 'Bad Token'}, status: 401
  end
end

curl http://localhost:3000/posts/1 -H 'Authorization: Token token=861af99a9dbf5e052b8b55cfc41e69d'
```

> Dummy SMTP server – Mailtrap.io
[http://mailtrap.io/](Mailtrap.io)

> Testing API

```ruby
# spec_helper
module ApiHelper
  include Rack::Test::Methods

  def app
    Rails.application
  end
end

RSpec.configure do |config|
  config.include ApiHelper, api: true
end

# spec
require 'spec_helper'

describe "api/v1/objects", api: true do
  let(:url) { "api/v1/objects" }
  let(:object) { Factory.create(:object) }
  let(:token) { "YOUR_SECRET_TOKEN" }
  let(:data) { JSON.parse(last_response.body) }

  before(:each) { get url, token: token }       # here's where API call

  subject { data }

  it { should have(1).object }
end
```

> File upload using Ruby on Rails 5 API

[https://www.pluralsight.com/guides/ruby-ruby-on-rails/handling-file-upload-using-ruby-on-rails-5-api](File upload Rails 5 API)

> Use HTTP Status Codes Correctly

```
200 - OK            - Everything went fine. I return the resource you requested.
201 - Created       - Voilá. We successfully created a new resource for you.
204 - No Content    - There is nothing to see here. Useful if you just
                      deleted an object successfully.
401 - Unauthorized  - You did not provide valid credentials.
404 - Not found     - Return this if a requested object could not be
                      found. (Or if you want to conceal the existence
                      of an invalidly requested resource)
422 - Unprocessable - Resource cannot be saved. Maybe a validation error?
      Entity

GET     - Retrieve and only retrieve data.
          Never change any data within a GET request.
POST    - Create a new resource
PATCH   - Update an existing resource (partially)
DELETE  - Remove a resource
```

> No Brainer Usage

Here is a quick example of what NoBrainer can do:

### Orders of [Callbacks][1] for Rethinkdb

When a document is created:

* ``before_validation``
* ``after_validation``
* ``before_save``
* ``before_create``
* ``after_create``
* ``after_save``

When a document is updated:

* ``before_validation``
* ``after_validation``
* ``before_save``
* ``before_update``
* ``after_update``
* ``after_save``

When an existing document is destroyed:

* ``before_destroy``
* ``after_destroy``

When a document is initialized with ``new``, or reinitialized with ``reload``:

* ``before_initialize``
* ``after_initialize``

When a document is fetched from the database:

* ``before_initialize``
* ``after_initialize``
* ``after_find``

The ``after_find`` callback will not be triggered again when calling ``reload``
on a model. ``around_*`` callbacks are available as usual.

```ruby
Use a :before_validation, :set_creation_date, :on => :create instead of a before_create
```

```ruby
require 'nobrainer'

NoBrainer.connect 'rethinkdb://localhost/blog'

class Post
  include NoBrainer::Document

  field :title
  field :body

  has_many :comments

  validates :title, :body, :presence => true
end

class Comment
  include NoBrainer::Document

  field :author
  field :body

  belongs_to :post

  validates :author, :body, :post, :presence => true

  after_create do
    puts "#{author} commented on #{post.title}"
  end
end

NoBrainer.purge!

post = Post.create!(:title => 'ohai', :body  => 'yummy')

puts post.comments.create(:author => 'dude').
  errors.full_messages == ["Body can't be blank"]

post.comments.create(:author => 'dude', :body => 'burp')
post.comments.create(:author => 'dude', :body => 'wut')
post.comments.create(:author => 'joe',  :body => 'sir')
Comment.all.each { |comment| puts comment.body }

post.comments.where(:author => 'dude').destroy
puts post.comments.count == 1
```

Features
---------

* Compatible with Rails 5
* Autogeneration of ID, MongoDB style
* Creation of database and tables on demand
* Attributes accessors (`attr_accessor`)
* Validation support, expected behavior with `save!`, `save`, etc. (uniqueness validation still in development)
* Validatation with create, update, save, and destroy callbacks.
* `find`, `create`, `save`, `update_attributes`, `destroy` (`*.find` vs. `find!`).
* `where`, `order_by`, `skip`, `limit`, `each`
* `update`, `inc`, `dec`
* `belongs_to`, `has_many`
* `to_json`, `to_xml`
* `attr_protected`
* Scopes
* Thread-safe
* Polymorphism

[1]: http://nobrainer.io/docs/callbacks/#orders_of_callbacks
