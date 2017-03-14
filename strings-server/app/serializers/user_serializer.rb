class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :middle_name, :last_name, :email, :role, :state, :admin, :auth_token, :description
  has_many :cards
  has_many :phones
  link(:self) { user_url(object) }
end
