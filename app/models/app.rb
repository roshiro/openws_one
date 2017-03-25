class App
  include Mongoid::Document
  field :name, type: String
  field :api_key, type: String
  field :user_id, type: Integer
end
