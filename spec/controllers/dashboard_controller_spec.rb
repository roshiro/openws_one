require 'rails_helper'

describe DashboardController do
  let(:user) { double('User') }

  describe '#index' do
    context 'when user is signed in' do
      before :each do
        allow(request.env['warden']).to receive(:authenticate!).and_return(user)
        allow(controller).to receive(:current_user).and_return(user)
      end

      it 'renders dashboard' do
        get :index
        expect(response).to render_template("index")
      end
    end

    context 'when user is not signed in' do
      before :each do
        allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
      end

      it 'redirects to signin page' do
        get :index
        expect(response).to redirect_to("http://test.host/users/sign_in")
      end
    end
  end
end
