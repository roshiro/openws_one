class StorageValidations
  def self.db_name_valid?(value)
    valid?(value, 20)
  end

  def self.project_name_valid?(value)
    valid?(value)
  end

  def self.collection_name_valid?(value)
    valid?(value)
  end

  private

  def self.valid?(value, max_length = 40)
    /^([a-z0-9\-_]{2,#{max_length}})$/.match(value).nil? ? false : true
  end
end
