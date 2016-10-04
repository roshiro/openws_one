module Openws
  class GeneralDocument
    include Mongoid::Document
    include Mongoid::Attributes::Dynamic
    store_in collection: "my_documents"
  end
end
