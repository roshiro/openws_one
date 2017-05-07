class Collection
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :app
  belongs_to :user

  field :name, type: String
  field :app_id, type: BSON::ObjectId
  field :user_id, type: BSON::ObjectId
  field :created_at, type: DateTime
  field :updated_at, type: DateTime

  validates_uniqueness_of :name
  # TODO: Implement format validation
  validates :name, length: { minimum: 2, maximum: 50 }

  # Returns the full collection name.
  def full_collection_name
    "#{app_id}.#{name}"
  end

  # Override BSON
  def as_json(*args)
   res = super
   res["app_id"] = res.delete("app_id").to_s
   res["user_id"] = res.delete("user_id").to_s
   res
  end
end
