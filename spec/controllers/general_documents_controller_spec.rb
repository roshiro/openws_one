require 'rails_helper'

describe GeneralDocumentsController do
  let(:document) { double("GeneralDocument") }

  before :each do
    allow(Openws::GeneralDocument).to receive(:new).and_return document
    allow(document).to receive(:save!)
    allow(document).to receive(:with).and_return document
  end

  describe '#create' do
    let(:body) do
      {
        name: 'Burger',
        price: 2.34
      }.to_json
    end

    it 'sets the collection name' do
      expect(document).to receive(:with).with(collection: 'my_prods')
      post :create, body, collection_name: 'my_prods'
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

  describe '#show' do
    let(:items) do
      [
        { key1: 'random1' },
        { key2: 'random2' },
        { key3: 'random3' }
      ]
    end

    before :each do
      allow(Openws::GeneralDocument).to receive(:with).with(collection: 'todo_list').and_return Openws::GeneralDocument
      allow(Openws::GeneralDocument).to receive_message_chain(:all).and_return items
    end

    describe 'when collection name exists' do
      it 'returns the list of JSON objects' do
        get :show, collection_name: 'todo_list'
        expect(response.body).to eq({ items: items }.to_json)
      end

      it 'returns status code 200' do
        get :show, collection_name: 'todo_list'
        expect(response.status).to eq 200
      end
    end

    describe 'when collection name does not exist' do
      it 'returns 400 status code' do
        # get :show, collection_name: 'todo_list'
        # expect(response.status).to eq 400
      end
    end
  end
end
