require 'rails_helper'

RSpec.describe CollectionItemsController, type: :controller do
  before :each do
  end

  describe '#create' do
    context 'when app does not exist' do
      it 'returns error code' do

      end
    end

    context 'when collection does not exist' do
      context 'and collection name is valid' do
        context 'and JSON is valid' do
          it 'saves the JSON in the collection' do
            
          end
        end

        context 'and JSON is invalid' do

        end
      end
    end

    context 'when app and collection exist' do

    end
  end

  describe '#show' do
  end

  describe '#update' do
  end

  describe '#destroy' do
  end
end
