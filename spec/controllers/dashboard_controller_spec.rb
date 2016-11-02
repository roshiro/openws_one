require 'rails_helper'

describe DashboardController do
  before :all do
    @user = FactoryGirl.create(:user)
  end

  after :all do
    @user.delete
  end

  describe '#index' do
    context 'when user is signed in' do
      it 'renders dashboard' do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        sign_in @user
        get :index
        expect(response).to render_template("index")
      end
    end

    context 'when user is not signed in' do
      it 'redirects to signin page' do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        sign_out @user
        get :index
        expect(response).to redirect_to("http://test.host/users/sign_in")
      end
    end
  end
end
