class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name,
    :middle_name, :auth_token, :description, :role,
    :state, :admin
  has_many :cards
  has_many :phones
  link(:self) { user_url(object) }
end
