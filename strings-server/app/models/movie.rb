class Movie
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  self.include_root_in_json = true

  field :title,         type: String,   required: true
  field :year,          type: Integer,  required: true
  field :rated,         type: String,   required: true
  field :released,      type: String,   required: true
  field :runtime,       type: Integer,  required: true
  field :genre,         type: String,   required: true
  field :director,      type: String,   required: true
  field :writer,        type: Text,     required: true
  field :actor,         type: String,   required: true
  field :plot,          type: Binary,   required: true
  field :language,      type: String,   required: true
  field :country,       type: String,   required: true
  field :award,         type: String,   required: true
  field :poster,        type: String,   required: true
  field :metascore,     type: Integer,  required: true
  field :imdb_rating,   type: String,   required: true
  field :imdb_vote,     type: String,   required: true
  field :imdb_id,       type: String,   required: true, uniq: true
  field :type,          type: String,   required: true
  field :response,      type: Boolean,  required: true

  index :title

  validates :title,         presence: true, length: { allow_blank: false }
  validates :year,          presence: true, length: { allow_blank: false }
  validates :rated,         presence: true, length: { allow_blank: false }
  validates :released,      presence: true, length: { allow_blank: false }
  validates :runtime,       presence: true, length: { allow_blank: false }
  validates :genre,         presence: true, length: { allow_blank: false }
  validates :director,      presence: true, length: { allow_blank: false }
  validates :writer,        presence: true, length: { allow_blank: false }
  validates :actor,         presence: true, length: { allow_blank: false }
  validates :plot,          presence: true, length: { allow_blank: false }
  validates :language,      presence: true, length: { allow_blank: false }
  validates :country,       presence: true, length: { allow_blank: false }
  validates :award,         presence: true, length: { allow_blank: false }
  validates :poster,        presence: true, length: { allow_blank: false }
  validates :metascore,     presence: true, length: { allow_blank: false }
  validates :imdb_rating,   presence: true, length: { allow_blank: false }
  validates :imdb_vote,     presence: true, length: { allow_blank: false }
  validates :imdb_id,       presence: true, length: { allow_blank: false }
  validates :type,          presence: true, length: { allow_blank: false }
  validates :response,      presence: true, length: { allow_blank: false }
end
