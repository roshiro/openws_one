class AppsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_app, only: :show

  def create
    render json: create_app
  end

  def show
    render json: @app
  end

  private

  def load_app
    @app ||= App.where(user_id: current_user.id, api_key: params[:id]).first
  end

  def create_app
    app = App.create(name: params[:app][:name])
    app.api_key = SecureRandom.uuid
    app.user_id = current_user.id
    app.save!
  end

end
