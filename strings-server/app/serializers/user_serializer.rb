class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :middle_name, :apikey, :email, :description
end
