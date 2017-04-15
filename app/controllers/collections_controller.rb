# Controller to handle Collections
class CollectionsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_collections, only: :index

  def index
    respond_to do |format|
      format.json { render json: { collections: @collections } }
    end
  end

  def create
    render json: create_collection
  end

  private

  def collection_params
    params.require(:collection).permit(:name)
  end

  def create_collection
    coll = Collection.create(name: params[:collection][:name])
    coll.user_id = current_user._id
    coll.app_id = params[:app_id]
    coll.save!
    coll
  end

  def load_collections
    @collections ||= Collection.where(user_id: current_user._id, app_id: params[:app_id])
  end
end
