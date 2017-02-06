class Token
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  self.include_root_in_json = true

  field :apikey, type: String, required: true, min_length: 25, uniq: true

  index :apikey

  validates :apikey, presence: true, length: { minimum: 25, allow_blank: false }
end
