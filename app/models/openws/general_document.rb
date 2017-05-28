# namespace for Openws
module Openws
  # Model representing any dinamic collection
  class GeneralDocument
    include Mongoid::Document
    include Mongoid::Attributes::Dynamic

    def self.namespaced_collection(coll)
      "public.#{coll}"
    end
  end
end
