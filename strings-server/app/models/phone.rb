class Phone
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps
  include ActionView::Helpers::NumberHelper

  belongs_to :user, foreign_key: :user_id, class_name: :User

  field :name,          type: String
  field :phone_number,  type: String
  field :user_id,       type: String

  index :user_id

  validates_presence_of :user

  validates :name,          presence: true, allow_blank: false, length: (3..15)
  validates :phone_number,  presence: true, allow_blank: false
  validates :user_id,       presence: true, allow_blank: false, length: (14)
end
