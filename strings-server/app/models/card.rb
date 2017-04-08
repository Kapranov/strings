class Card
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  belongs_to :room, foreign_key: :room_id, class_name: :Room
  belongs_to :user, foreign_key: :user_id, class_name: :User

  self.include_root_in_json = true

  field :content, type: Text,     required: true
  field :color,   type: String,   required: true
  field :user_id, type: String,   required: true
  field :room_id, type: String,   required: true
  field :votes,   type: Integer,  required: true

  index :user_id
  index :room_id

  validates_presence_of :user
  validates_presence_of :room

  validates :content, presence: true
  validates :color,   presence: true
  validates :user_id, presence: true
  validates :room_id, presence: true
  validates :votes,   presence: true
end
