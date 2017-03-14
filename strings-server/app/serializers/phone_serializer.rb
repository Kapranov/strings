class PhoneSerializer < ActiveModel::Serializer
  attributes :id, :name, :phone_number, :user_id
  belongs_to :user
end
