class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :middle_name, :token, :email, :description


  # def description
  #  descriptions = object.description.split(" ")
  #  "#{descriptions[0].first}. #{descriptions[1][1]}"
  # end
end
