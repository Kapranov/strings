class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :middle_name, :last_name, :email, :role, :state, :admin, :auth_token, :description
  has_many :cards,  embed: :ids
  has_many :phones, embed: :ids
end
