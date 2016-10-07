require 'rails_helper'

describe GeneralDocumentsController do
  describe '#create' do
    let(:document) { double("GeneralDocument") }
    let(:body) do
      {
        name: 'Burger',
        price: 2.34
      }.to_json
    end

    before :each do
      allow(Openws::GeneralDocument).to receive(:new).and_return document
      allow(document).to receive(:save!)
    end

    describe 'for a valid JSON body' do
      it 'returns code 201' do
        post :create, body, collection_name: 'my_prods'
        expect(response.status).to eq 201
      end

      it 'persists the given JSON' do
        expect(document).to receive(:save!)
        post :create, body, collection_name: 'my_prods'
      end
    end

    describe 'for invalid JSON body' do
      it 'returns error response' do
        post :create, collection_name: 'my_prods'
        expect(response.body).to eq({ msg: 'Invalid JSON' }.to_json)
      end
    end

    describe 'for empty JSON' do
      it 'returns error response' do
        post :create, '{}', collection_name: 'my_prods'
        expect(response.body).to eq({ msg: 'JSON cannot be empty' }.to_json)
      end

      it 'returns error 400' do
        post :create, '{}', collection_name: 'my_prods'
        expect(response.status).to eq 400
      end
    end
  end
end
