class User
  include DataMapper::Resource

  property :id, Serial
  property :first_name, String
  property :last_name, String
  property :middle_name, String
  property :email, String
  property :token, String
  property :description, String
  property :created_at, DateTime
  property :updated_at, DateTime

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :middle_name
  validates_presence_of :email
  validates_presence_of :token
  validates_presence_of :description
end
