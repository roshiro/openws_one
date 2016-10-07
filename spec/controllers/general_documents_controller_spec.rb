require 'rails_helper'

describe GeneralDocumentsController do
  describe '#index' do
    it 'returns successful response' do
      get :index
      expect(response).to be_success
    end
  end

  describe '#new' do
    it 'returns successful response' do
      get :new
      expect(response).to be_success
    end
  end

  describe '#create' do
    describe 'for a valid JSON body' do
      it 'returns success response' do
        # post :create, id: 
      end

      it 'persists the given JSON' do

      end
    end

    describe 'for invalid JSON body' do
      it 'returns error response' do

      end
    end
  end
end
