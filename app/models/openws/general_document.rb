# namespace for Openws
module Openws
  # Model representing any dinamic collection
  class GeneralDocument
    include Mongoid::Document
    include Mongoid::Attributes::Dynamic

    # Store documents in general database
    store_in database: 'general'
  end
end
