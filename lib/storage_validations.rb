# Class with validations for collection names,
# database names and project names.
class StorageValidations
  # Validates database name
  # @param value [String] database name to be validated
  # @return [Boolean]
  def self.db_name_valid?(value)
    valid?(value, 20)
  end

  # Validates project name
  # @param value [String] project name to be validated
  # @return [Boolean]
  def self.project_name_valid?(value)
    valid?(value)
  end

  # Validates collection name
  # @param value [String] collection name to be validated
  # @return [Boolean]
  def self.collection_name_valid?(value)
    valid?(value)
  end

  private

  def self.valid?(value, max_length = 40)
    /^([a-z0-9\-_]{2,#{max_length}})$/.match(value).nil? ? false : true
  end
end
