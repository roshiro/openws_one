require 'rails_helper'

describe Rack::Attack do
  include Rack::Test::Methods

  def app
    Rails.application
  end

  let(:documents) { double("Docs") }

  before :each do
    allow(Openws::GeneralDocument).to receive(:with).and_return documents
    allow(documents).to receive(:exists?).and_return true
    allow(documents).to receive(:all)
  end

  describe 'throttling requests by IP address' do
    let(:limit) { 50 }
    context 'number of request is lower than limit' do
      it 'does not return code 429' do
        limit.times do
          get '/api/collections/my_coll_name', {}, 'REMOTE_ADDR' => '1.2.3.4'
          expect(last_response.status).to_not eq(429)
        end
      end
    end

    context 'number of request is higher than limit' do
      it 'returns code 429' do
        (limit + 10).times do |i|
          get '/api/collections/my_coll_name', {}, 'REMOTE_ADDR' => "4.3.2.1"
          expect(last_response.status).to eq(429) if i > limit
        end
      end
    end

    context 'request is made from IP in safelist' do
      it 'does not return code 429' do
        (limit + 10).times do
          get '/api/collections/my_coll_name', {}, 'REMOTE_ADDR' => '127.0.0.1'
          expect(last_response.status).to_not eq(429)
        end
      end
    end

    context 'not requesting API' do
      it 'does not return code 429' do
        (limit + 10).times do
          get '/', {}, 'REMOTE_ADDR' => '1.2.3.4'
          expect(last_response.status).to_not eq(429)
        end
      end
    end
  end
end
