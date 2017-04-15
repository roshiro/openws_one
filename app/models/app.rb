class App
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  has_many :collections

  field :name, type: String
  field :api_key, type: String
  field :user_id, type: BSON::ObjectId
  field :created_at, type: DateTime
  field :updated_at, type: DateTime
end
