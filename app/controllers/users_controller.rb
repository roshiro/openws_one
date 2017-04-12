# Controller to handle User actions
class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_user_profile, only: :profile

  def profile
    render json: @profile, status: :ok
  end

  private

  def load_user_profile
    @profile ||= {
      email: 'rafael.oshiro@gmail.com',
      api_key: SecureRandom.uuid
    }
  end
end
