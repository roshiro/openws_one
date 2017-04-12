class App
  include Mongoid::Document

  belongs_to :user

  field :name, type: String
  field :api_key, type: String
  field :user_id, type: BSON::ObjectId
end
