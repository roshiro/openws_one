require 'rails_helper'

describe StorageValidations do
  describe '.db_name_valid?' do
    it_should_behave_like 'storage name validations', :db_name_valid?, 20
  end

  describe '.project_name_valid?' do
    it_should_behave_like 'storage name validations', :project_name_valid?, 40
  end

  describe '.collection_name_valid?' do
    it_should_behave_like 'storage name validations', :collection_name_valid?, 40
  end
end
