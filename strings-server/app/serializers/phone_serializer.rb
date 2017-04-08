class PhoneSerializer < ActiveModel::Serializer
  attributes :id, :name, :phone_number, :user_id, :created_at, :updated_at
  belongs_to :user, url: ->(user){ "/users/#{user.id}/phones" }
  link(:self) { user_url(object.user_id) }

  def url
    phone_url(object)
  end

  def created_at
    "#{object.created_at.to_s(:long)}"
  end

  def updated_at
    "#{object.updated_at.to_s(:long)}"
  end
end
