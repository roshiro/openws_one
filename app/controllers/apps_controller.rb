class AppsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_app, only: [:show, :destroy]

  def index
    render json: { applications: current_user.apps }
  end

  def create
    render json: create_app
  end

  def show
    respond_to do |format|
      format.json { render json: { application: @app } }
      format.html { render 'dashboard/index' }
    end
  end

  def destroy
    render json: @app.destroy
  end

  private

  def app_params
    params.require(:app).permit(:name)
  end

  def load_app
    @app ||= current_user.apps.where(id: params[:id]).first
  end

  def create_app
    app = App.create(name: params[:app][:name])
    app.api_key = SecureRandom.uuid
    app.user_id = current_user._id
    app.save!
    app
  end

end
