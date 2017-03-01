> Authenticating Your API

[http://requestb.in/](Inspect HTTP Requests)


```
curl http://localhost:3000/
curl -I -v http://localhost:3000
curl -I --trace-ascii - http://localhost:3000
curl -I http://localhost:3000/

curl -u Oleg%20G.Kapranov:87654321 http://localhost:3000/

curl -u Oleg.G.Kapranov:87654321 http://localhost:3000/
curl -u Oleg.G.Kapranov:87654321 http://localhost:3000/api/users

curl -H "Authorization: Token token=aEghsJrLyTnYcw0ejZzQxY6gKzOk2rRrUQtt" http://localhost:3000/
curl -H "Authorization: Token token=aEghsJrLyTnYcw0ejZzQxY6gKzOk2rRrUQtt" http://localhost:3000/api/users
curl -H "Authorization: Token token=aEghsJrLyTnYcw0ejZzQxY6gKzOk2rRrUQtt" http://localhost:3000/api/users?token=iQIrdobu5FU6XMDe2QzSmfIkCk7H2ySdtQtt
```

```
GET       - http://localhost:3000/api/v1/users?token=Params
POST      - http://localhost:3000/api/v1/users?token=Params
GET       - http://localhost:3000/api/v1/users/id?token=Params
PUT/PATCH - http://localhost:3000/api/v1/users/id?token=Params
```

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

> NoBrainer Usage

Here is a quick example of what [NoBrainer][1] can do:

### Orders of [Callbacks][1] for [Rethinkdb][2]

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

```ruby
Token.where(:id => /4QPezySrjb82KQ/).order_by(:username => :desc).to_a
token = Token.first
token.apikey
token[:apikey].empty?
token[:apikey].present?
# may be used to check on various object types like empty string "" or empty array []
token[:apikey].empty?
# checks for nil? or empty?
token[:apikey].blank?
# checks to see if variable is referencing an object or not
token[:apikey].nil?

if token[:apikey].empty?
  token[:apikey] = token[:body].scan(/\w+/)[0..2].join(' ')
end

token[:created_at] = Time.now.to_i
token.created_at
token[:created_at] = Time.at(token['created_at'])

token[:username]
token[:username].downcase

Token.where(:apikey => 'TaCwuILwEDWOR2XJ1Es2PrFG1DLGqtdVYgtt').sample(1)

Token.where(lock: id).update_all lock: nil
```

```javascript
r.db("strings").table("token").filter({password: "87654321"})

r.table('users')
 .concatMap(r.row('inventory').default([]))
 .eqJoin('name', r.table('prices'))

r.table('data').indexCreate('timestamp')
r.table('data').orderBy({index: 'timestamp'})
r.table('data').between(r.now().sub(60*60), r.now(), {index: 'timestamp'})
r.table('data').between(r.now().sub(60*60), r.maxval, {index: 'timestamp'}).orderBy({index: 'timestamp'})
r.table('data').orderBy({index: 'timestamp'}).filter({colour: 'red'})
r.table('data').filter({colour: 'red'}).orderBy('timestamp')

r.union(
  r.table('table1').changes(),
  r.table('table2').changes()
).run(conn)

r.db('dbone').table("usertable").filter(r.row("userid").eq("002")).pluck('Min')("Min").sum()
r.db('dbone').table("usertable").filter(r.row("userid").eq("002")).pluck('Min').sum("Min")

r.db("table").table("products").filter(function(row){
     return row("title").downcase().match("(.*)microsoft(.*)").and(row("price").lt(100));
})

r.table('friends').getAll(userId, {index: 'user_id'})

r.db("strings").table("users").group("created_at").max("created_at").ungroup()

r.table('posts').get(POST_ID).update({user_id: USER_ID})

r.table('transactions').insert(
  r.table('records').concatMap(function (doc){return doc('transactions')})
)

r.table('users').filter(lambda user: r.expr([1,2,3])
  .contains(user['id']) & (user['active'] == 1))

r.table('users')
  .filter(lambda user: r.expr([1,2,3])
    .contains(user['id']) & (user['active'] == 1)) r.table('users')
      .filter(lambda user: r.all(r.expr([1,2,3])
        .contains(user['id']), user['active'] == 1))

r.db('admin').table('services')
  .filter(function (service) { return service('appkey')
    .hasFields('YcJ1HR6vjebXNHwOzeC2l2EAvUNw8qyp') })

r.db('strings').table('tokens').getField('apikey')

r.db('test')
 .table('test')
 .getAll(1, {index: 'record'})
 .getField('data')
 .concatMap(r.row.coerceTo('array'))
 .group(r.row(0))
 .concatMap([r.row(1)])
 .ungroup()

r.db('strings').table('tokens').getAll('4QPezySrjb82KQ')
r.db('strings').table('tokens').getAll('4QPezySrjb82KQ').changes()
r.db('strings').table('tokens').get('4QPezySrjb82KQ').keys()
```
> RethinkDB supports different types of secondary indexes:

1. Simple indexes based on the value of a single field.
2. Compound indexes based on multiple fields.
3. Multi indexes based on arrays of values.
4. Indexes based on arbitrary expressions.

```
class Post
 field field1
 field field2

 index :fields_lambda, ->(doc){ doc[‘field1’] + “_” + doc[‘field2’] }
end

Post.where(:fields_lambda => 'John_Saucisse')

rake db:update_indexes
NoBrainer.update_indexes
Model.perform_update_indexes
```

> The users could specify the uuid generation scheme on table creation:

```
> r.uuid(scheme='random').run()
'e0f75d10-d770-4434-ae3e-23194ffbe581'

> r.uuid(scheme='ordered').run()
'2014-09-17;05:15:59.123;e0f7'

> r.table_create('foo', id_scheme='ordered')
```

```
r.db('myDb').table('myTable').insert({
  "name": "Andrew",
  "age": 20,
  "interests": ["reading", "playing guitar", "pop music"],
  "contact info": {
    "email": "andrew@example.com",
    "phone": "5555555555"
  }
})

r.db('myDb').table('myTable').insert([{
  "name": "Carl",
  "age": 25,
  "interests": ["sports", "pizza", "poetry"],
  "contact info": {
    "email": "carl@example.com",
    "phone": "5555555555"
  }
},
{
  "name": "Sophia",
  "age": 21,
  "interests": ["playing golf", "solving puzzles", "rock music"],
  "contact info": {
    "email": "sophia@example.com",
    "phone": "5555555555"
  }
}])

r.db('myDb').table('myTable').get("0530c22a-db04-4d22-a9a9-df82c1b76196")

r.db('myDb').table('myTable').limit(1)

r.db('myDb').table('myTable').filter({name: "Andrew"})
r.db('myDb').table('myTable').filter(r.row("name").eq("Andrew"))
r.db('myDb').table('myTable').filter(r.row("age").gt(22))
r.db('myDb').table('myTable').filter(r.row("contact info")("phone").eq("5555555555"))
r.db('myDb').table('myTable').filter(r.row("age").eq("21").or(r.row("age").eq("25")))
r.db('myDb').table('myTable').filter(r.row("interests").contains("reading"))
r.db('myDb').table('myTable').pluck("name", "interests")
r.db("myDb").table("myTable").orderBy("name")
r.db("myDb").table("myTable").orderBy(r.desc("name"))
r.db('myDb').table('myTable').update({gender: "male"})
r.db('myDb').table('myTable').filter({name: "Sophia"}).update({gender: "female"})
r.db('myDb').table('myTable').get("0530c22a-db04-4d22-a9a9-df82c1b76196").delete()
r.db('myDb').table('myTable').filter(r.row("name").eq("Sophia")).delete()
r.db('myDb').table('myTable').delete()
r.db('myDb').table('myTable').count()
r.db('myDb').tableDrop('myTable')
r.dbDrop('myDb')
r.dbCreate('myDb')
r.db('myDb').tableCreate("people")
r.dbList()
r.db("myDb").tableList()
r.db("myDb").table("people").indexCreate("name")
r.db("myDb").table("people").indexCreate("name_age_index", [r.row("name"), r.row("age")])
r.db("myDb").table("people").getAll(["Andrew", 21], {index: "name_age_index"})
r.db("myDb").table("interests").indexCreate("people_id")
r.db("myDb").table("people").eqJoin(
  "id",
  r.db("myDb").table("interests"),
  {index: 'people_id'}
}

r.db("myDb").table("people").merge(
  function (person) {
    return {
      interest_ids: r.db("myDb").table('interests').filter(function (interestDoc) {
        return person('interest_ids').contains(interestDoc('id'));
      }).coerceTo('array')
    }
  })

r.db("myDb").table("people").changes().run(conn).then(function(cursor) {
  cursor.each(console.log);
});

r.db("myDb").table("people").filter(r.row("age").lt(20)).changes()

r.db("myDb").table("people").changes({squash: 5})
```

> Webhook and Non-REST-ful Requests

Webhooks allow developers to build apps that receive information, in
near–real time, about events that happen on Github. Webhooks
require you to provide a callback URI where you want us to send
information about the events that your app subscribes to.When the event
happens Github will send a POST request to your callback URI and
then your app can perform some action based on that event.

Depending on your use case, standard REST requests can’t always be sent.
I’ve worked with systems that can only send GET requests, so all payload
information and authentication must appear in the query string.

If your application needs to respond to these Webhooks requests that are
used by a limited client that doesn’t understand REST, you need to build
a non-REST-ful interface.

For that case, I create a special endpoint and set up a controller that
maps the get request into a processing request. Here, I accept the
request and send it off into an ActiveJob so we can quickly return for
the client.

Here are few examples for such events

* An order is placed.
* A product is added.
* A customer record is updated.

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

> [JSON Web Token][5] (JWT) is an open standard (RFC 7519)

That defines a compact and self-contained way for securely transmitting
information between parties as a JSON object. This information can be
verified and trusted because it is digitally signed. JWTs can be signed
using a secret (with HMAC algorithm) or a public/private key pair using
RSA.

You can browse to [jwt.io][6] where you can play with a JWT and put these
concepts in practice. [jwt.io][6] allows you to decode, verify and generate
JWT.

Let’s explain some concepts of this definition further.

* **Compact:** Because of its size, it can be sent through an URL, POST
  parameter, or inside an HTTP header. Additionally, due to its size its
  transmission is fast.
* **Self-contained:** The payload contains all the required information
  about the user, to avoid querying the database more than once.


### When should you use JSON Web Tokens?

These are some scenarios where JSON Web Tokens are useful:

* **Authentication:** This is the typical scenario for using JWT, once
  the user is logged in, each subsequent request will include the JWT,
  allowing the user to access routes, services, and resources that are
  permitted with that token. Single Sign On is a feature that widely uses
  JWT nowadays, because of its small overhead and its ability to be easily
  used among systems of different domains.
* **Information Exchange:** JWTs are a good way of securely transmitting
  information between parties, because as they can be signed, for
  example using a public/private key pair, you can be sure that the sender
  is who he says he is. Additionally, as the signature is calculated using
  the header and the payload, you can also verify that the content hasn’t
  changed.


### Which is the JSON Web Token structure?

JWTs consist of three parts separated by dots ``(.)``, which are:

* **Header**
* **Payload**
* **Signature**

Therefore, a JWT typically looks like the following.

```
xxxxx.yyyyy.zzzzz
```

Let’s break down the different parts.

### Header

The header **typically** consists of two parts: the type of the token,
which is JWT, and the hashing algorithm such as HMAC SHA256 or RSA.

For example:

```
{
  "alg": "HS256",
  "typ": "JWT"
}
```

Then, this JSON is Base64Url encoded to form the first part of the JWT.

### Payload

The second part of the token is the payload, which contains the claims.
Claims are statements about an entity (typically, the user) and
additional metadata. There are three types of claims: **reserved**,
**public**, and **private** claims.

* **Reserved claims:** These are a set of predefined claims, which are
  not mandatory but recommended, thought to provide a set of useful,
  interoperable claims. Some of them are: **iss**(issuer), **exp**
  (expiration time), **sub** (subject), **aud** (audience), among
  others.

> Notice that the claim names are only three characters long as JWT is
> meant to be compact.

* **Public claims:** These can be defined at will by those using JWTs.
  But to avoid collisions they should be defined in the IANA JSON Web
  Token Registry or be defined as a URI that contains a collision
  resistant namespace.
* **public:** These are the custom claims created to share information
  between parties that agree on using them.

An example of payload could be:

```
{
  "sub": "1234567890",
  "name": "John Doe",
  "admin": true
}
```

The payload is then **Base64Url** encoded to form the second part of
the JWT.

### Signature

To create the signature part you have to take the encoded header, the
encoded payload, a secret, the algorithm specified in the header, and
sign that.

For example if you want to use the HMAC SHA256 algorithm, the signature
will be created in the following way.

```
HMACSHA256(
  base64UrlEncode(header) + "." +
  base64UrlEncode(payload),
  secret)
```

The signature is used to verify that the sender of the JWT is who it
says it is and to ensure that the message was’t changed in the way.

### Putting all together

The output is three Base64 strings separated by dots that can be easily
passed in HTML and HTTP environments, while being more compact compared
to XML-based standards such as SAML.

The following shows a JWT that has the previous header and payload
encoded and it is signed with a secret.

```
eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.
eyJ1c2VyX2lkIjoiNFRZTmZhdmZBZ1MzTWEiLCJlbWFpbCI6Imx1Z2F0ZXhAeWFob28uY29tIn0.
oPdFdPAoKQARunvCAd58X01SXzo5CMtPc8hTv99Ovvg
```

```
ALGORITHM = 'HS256'
hmac_secret = 'somethingrandomrandom'
expiry_in_minutes=60*24*30
payload = {id: user.id, exp: expiry_in_minutes.minutes.from_now.to_i}

token = JWT.encode payload, hmac_secret, ALGORITHM
decoded = JWT.decode(token, hmac_secret, true, { leeway: leeway, algorithm: ALGORITHM })

curl -X POST -d email="a@a.com" -d username="Kapranov" -d password="changeme" http://localhost:3000/register

{"token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6NSwiZXhwIjoxNDkwOTgzMjQ1fQ.upYr7weENIh6uNfLxzPvdZYupZrRS2tzSkUODeEUMGY","user":{"id":5,"username":"Kapranov"}}

curl --header "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6NSwiZXhwIjoxNDkwOTgzMjQ1fQ.upYr7weENIh6uNfLxzPvdZYupZrRS2tzSkUODeEUMGY" http://localhost:3000/rooms

curl -X POST -d email="a@a.com" -d username="Kapranov" -d password="changeme" http://localhost:3000/login

{"token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6NSwiZXhwIjoxNDkwOTg0MDkyfQ.rJKvNAt3F4RPmT3ebUBwMfdTwl_hV6euXuhz2_QT4ts","user":{"id":5,"username":"Kapranov"}}
```

[1]:  http://nobrainer.io/docs/callbacks/#orders_of_callbacks
[2]:  https://www.rethinkdb.com/api/ruby/
[3]:  https://github.com/nviennot/nobrainer
[4]:  https://github.com/luiscript/graphql-rethinkdb-x
[5]:  https://jwt.io/introduction/
[6]:  https://jwt.io/
[7]:  https://github.com/auth0/node-jsonwebtoken
[8]:  https://github.com/MichielDeMey/express-jwt-permissions
[9]:  https://github.com/dwyl/learn-json-web-tokens
[10]: https://github.com/auth0/express-jwt
[11]: https://github.com/kazu69/jwt-express-example
