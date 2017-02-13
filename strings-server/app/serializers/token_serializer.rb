class TokenSerializer < ActiveModel::Serializer
  attributes :id, :apikey, :username, :password
end
