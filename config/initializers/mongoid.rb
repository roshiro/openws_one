module Mongoid
  module Document
    # Override as_json in order to return `id` key instead of `_id`
    # @param options [Hash] options
    # @return [String] JSON representation of the document
    def as_json(options={})
      attrs = super(options)
      { "id" => attrs["_id"].to_s }.merge(attrs.except("_id"))
    end
  end
end
