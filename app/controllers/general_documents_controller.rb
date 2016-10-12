# Controller to handle General Document actions
class GeneralDocumentsController < ApplicationController
  # Receive calls without passing CSRF token
  protect_from_forgery with: :null_session

  def create
    begin
      created_object = persist_in_collection(params[:collection_name])
      render json: created_object, status: 201
    rescue JSON::ParserError
      render json: { msg: 'Invalid JSON' }, status: 400
    rescue => e
      render json: { msg: e.message }, status: 400
    end
  end

  def show
    if Openws::GeneralDocument.with(collection: params[:collection_name]).exists?
      render json: {
        items: Openws::GeneralDocument.with(collection: params[:collection_name]).all
      }
    else
      render json: { msg: 'Invalid collection' }, status: 400
    end
  end

  def search_by_id
    begin
      result = Openws::GeneralDocument.with(collection: params[:collection_name]).find(params[:id])
      render json: result, status: 200
    rescue => e
      render json: { msg: 'Document not found' }, status: 404
    end
  end

  private

  def persist_in_collection(coll_name)
    raise 'JSON cannot be empty' if JSON.parse(request.body.read).empty?

    Openws::GeneralDocument
      .new(JSON.parse(request.body.read))
      .with(collection: coll_name)
      .save!
  end
end
