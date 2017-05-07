# Controller to handle Collections
class CollectionsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_collections, only: :index
  before_filter :load_collection, only: :destroy

  def index
    respond_to do |format|
      format.json { render json: { collections: @collections } }
    end
  end

  def create
    render json: create_collection
  end

  def destroy
    if @collection.destroy
      render json: { msg: 'Collection deleted successfuly.' }, status: :ok
    else
      render json: { msg: 'Error deleting collection.' }, status: :internal_server_error
    end
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

  def load_collection
    @collection ||= Collection.where(
                                      _id: BSON::ObjectId(params[:id]),
                                      user_id: current_user._id,
                                      app_id: BSON::ObjectId(params[:app_id])
                                    ).first
  end
end
