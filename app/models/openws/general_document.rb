# namespace for Openws
module Openws
  # Model representing any dinamic collection
  class GeneralDocument
    include Mongoid::Document
    include Mongoid::Attributes::Dynamic

    # Sets the collection name to be used
    # @param coll_name [String] name of the collection
    # @return [Class] self
    def self.set_collection_name(coll_name)
      store_in collection: coll_name
      self
    end
  end
end
