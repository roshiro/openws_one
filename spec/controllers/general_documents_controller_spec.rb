require 'rails_helper'

describe GeneralDocumentsController do
  let(:document) { double("GeneralDocument") }

  before :each do
    allow(Openws::GeneralDocument).to receive(:with).and_return document
    allow(document).to receive(:create!)
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
      expect(Openws::GeneralDocument).to receive(:with).with(collection: 'my_prods')
      post :create, body, collection_name: 'my_prods'
    end

    describe 'for invalid collection name' do
      before :each do
        allow(StorageValidations).to receive(:collection_name_valid?).with('employees+').and_return false
      end

      it 'returns 400 error code' do
        post :create, body, collection_name: 'employees+'
        expect(response.status).to eq(400)
      end
    end

    describe 'for a valid JSON body' do
      it 'returns code 201' do
        post :create, body, collection_name: 'my_prods'
        expect(response.status).to eq 201
      end

      it 'persists the given JSON' do
        expect(document).to receive(:create!)
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
    let(:doc_not_exist) { double("DocNotExist") }

    before :each do
      allow(Openws::GeneralDocument).to receive(:with).with(collection: 'non_existing_collection').and_return doc_not_exist
      allow(doc_not_exist).to receive(:exists?).and_return false
      allow(Openws::GeneralDocument).to receive(:with).with(collection: 'todo_list').and_return document
      allow(document).to receive(:exists?).and_return true
      allow(document).to receive(:all).and_return items
    end

    describe 'when collection name exists' do
      it 'returns the list of JSON objects' do
        get :show, collection_name: 'todo_list'
        expect(response.body).to eq(items.to_json)
      end

      it 'returns status code 200' do
        get :show, collection_name: 'todo_list'
        expect(response.status).to eq 200
      end
    end

    describe 'when collection name does not exist' do
      it 'returns 400 status code' do
        get :show, collection_name: 'non_existing_collection'
        expect(response.status).to eq 400
      end
    end
  end

  describe '#search_by_id' do
    let(:expected_obj) { { name: 'Random Product' } }

    before :each do
      allow(Openws::GeneralDocument).to receive(:with).with(collection: 'my_prods').and_return document
      allow(document).to receive(:find).with("109").and_return expected_obj
      allow(document).to receive(:find).with("9898").and_raise(Mongoid::Errors::DocumentNotFound)
    end

    describe 'when ID is found' do
      it 'returns the JSON object' do
        get :search_by_id, collection_name: 'my_prods', id: 109
        expect(response.body).to eq expected_obj.to_json
      end

      it 'returns status 200' do
        get :search_by_id, collection_name: 'my_prods', id: 109
        expect(response.status).to eq 200
      end
    end

    describe 'when ID is not found' do
      it 'returns status 404' do
        get :search_by_id, collection_name: 'my_prods', id: 9898
        expect(response.status).to eq 404
      end
    end
  end

  describe '#destroy' do
    before :each do
      allow(Openws::GeneralDocument).to receive(:with).with({collection: 'non_existing_collection'}).and_raise(Mongoid::Errors::DocumentNotFound, "Error")
      allow(Openws::GeneralDocument).to receive(:with).with(collection: 'my_prods').and_return document
      allow(document).to receive(:where).with(id: 'existing_id').and_return document
      allow(document).to receive(:where).with(id: 'non_existing_id').and_raise "error"
      allow(document).to receive(:delete)
    end

    describe 'when collection name does not exist' do
      it 'returns status 404' do
        delete :destroy_by_id, collection_name: 'non_existing_collection', id: 'non_existing_id'
        expect(response.status).to eq 404
      end

      it 'does not deletes any document' do
        expect(document).not_to receive(:delete)
        delete :destroy_by_id, collection_name: 'non_existing_collection', id: 'non_existing_id'
      end
    end

    describe 'when ID does not exist' do
      it 'returns status 404' do
        delete :destroy_by_id, collection_name: 'my_prods', id: 'non_existing_id'
        expect(response.status).to eq 404
      end

      it 'does not deletes any document' do
        expect(document).not_to receive(:delete)
        delete :destroy_by_id, collection_name: 'my_prods', id: 'non_existing_id'
      end
    end

    describe 'when params are correct' do
      it 'deletes the document' do
        expect(Openws::GeneralDocument).to receive(:with).with(collection: 'my_prods')
        expect(document).to receive(:where).with(id: 'existing_id')
        expect(document).to receive(:delete)
        delete :destroy_by_id, collection_name: 'my_prods', id: 'existing_id'
      end

      it 'returns status 201' do
        delete :destroy_by_id, collection_name: 'my_prods', id: 'existing_id'
        expect(response.status).to eq 201
      end
    end
  end

  describe '#update' do
    let(:body) do
      {
        "id" => 'existing_id',
        "name" => 'Beef Burger with tomato',
        "price" => 4.99
      }
    end

    before :each do
      allow(Openws::GeneralDocument).to receive(:with).with(collection: 'my_prods').and_return document
      allow(document).to receive(:find).with('existing_id').and_return document
      allow(document).to receive(:find).with('non_existing_id')
        .and_raise(Mongoid::Errors::DocumentNotFound, "Error")
    end

    context 'when document is not found' do
      before :each do
        put :update, body.to_json, collection_name: 'my_prods', id: 'non_existing_id'
      end

      it 'returns 404' do
        expect(response.status).to eq 404
      end

      it 'returns helpful message' do
        expect(response.body).to eq({ msg: 'Document not found' }.to_json)
      end
    end

    context 'when document is found' do
      before :each do
        allow(document).to receive(:update_attributes!).and_return body
      end

      it 'returns 200' do
        put :update, body.to_json, collection_name: 'my_prods', id: 'existing_id'
        expect(response.status).to eq 200
      end

      it 'returns updated document' do
        put :update, body.to_json, collection_name: 'my_prods', id: 'existing_id'
        expect(response.body).to eq(document.to_json)
      end

      it 'updates the document' do
        expect(document).to receive(:update_attributes!).with(body.except("id").except("_id"))
        put :update, body.to_json, collection_name: 'my_prods', id: 'existing_id'
      end
    end
  end
end
