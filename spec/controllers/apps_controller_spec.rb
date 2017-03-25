require 'rails_helper'

RSpec.describe AppsController, type: :controller do
  let(:user) { User.new }
  let(:app_json) { { name: 'My Test Application' } }
  let(:instance) { App.new }
  let(:api_key) { '12b2883e-bd2f-48bb-8320-60e6096862d1' }

  before :each do
    allow(request.env['warden']).to receive(:authenticate!).and_return(user)
    allow(controller).to receive(:current_user).and_return(user)
    allow(SecureRandom).to receive(:uuid).and_return api_key
  end

  describe '#create' do
    before :each do
      allow(App).to receive(:create).and_return instance
      allow(instance).to receive(:save!).and_return instance
    end

    it 'saves the instance of App' do
      expect(instance).to receive(:save!).and_return instance
      xhr :post, :create, { app: app_json }
    end

    it 'returns the created instance of App' do
      xhr :post, :create, { app: app_json }
      expect(response.body).to eq(instance.to_json)
    end

    it 'returns the api key' do
      xhr :post, :create, { app: app_json }
      expect(JSON.parse(response.body)['api_key']).to eq(api_key)
    end
  end

  describe '#show' do
    before :each do
      allow(App).to receive(:where).with(user_id: user.id, api_key: 'some_key').and_return([instance])
    end

    it 'returns the App' do
      xhr :get, :show, { id: 'some_key' }
      expect(response.body).to eq(instance.to_json)
    end
  end

end
