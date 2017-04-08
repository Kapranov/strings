class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name,
    :middle_name, :auth_token, :description, :role,
    :state, :admin, :created_at, :updated_at
  has_many :phones, data: true do
    link(:self) { user_phones_url(object) }
  end
  has_many :cards, data: true do
    link(:self) { user_cards_url(object) }
  end
  link(:self) { user_url(object.id) }

  def url
    user_url(object)
  end

  def created_at
    "#{object.created_at.to_s(:long)}"
  end

  def updated_at
    "#{object.updated_at.to_s(:long)}"
  end
end
