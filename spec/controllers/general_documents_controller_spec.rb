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
end
