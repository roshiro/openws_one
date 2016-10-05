require "rails_helper"

describe Openws::GeneralDocument do
  describe '.set_collection_name' do
    it 'changes the collection name' do
      expect(described_class).to receive(:store_in).with(collection: 'my_dummy_collection')
      described_class.set_collection_name('my_dummy_collection')
    end

    it 'returns self' do
      expect(described_class.set_collection_name('my_dummy_collection')).to be Openws::GeneralDocument
    end
  end
end
