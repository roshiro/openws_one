# Controller to handle General Document actions
class GeneralDocumentsController < ApplicationController
  # Receive calls without passing CSRF token
  protect_from_forgery with: :null_session

  # Creates a document in the given collection.
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

  # Returns all the documents from the given collection
  def show
    if Openws::GeneralDocument.with(collection: params[:collection_name]).exists?
      render json: {
        items: Openws::GeneralDocument.with(collection: params[:collection_name]).all
      }
    else
      render json: { msg: 'Invalid collection' }, status: 400
    end
  end

  # Returns the document from the given collection
  def search_by_id
    begin
      result = Openws::GeneralDocument.with(collection: params[:collection_name]).find(params[:id])
      render json: result, status: 200
    rescue => e
      render json: { msg: 'Document not found' }, status: 404
    end
  end

  # Destroys the document by ID.
  def destroy_by_id
    begin
      Openws::GeneralDocument.with({collection: params[:collection_name]}).where(id: params[:id]).delete
      render json: nil, status: 201
    rescue => e
      render json: { msg: 'Document not found' }, status: 404
    end
  end

  private

  def persist_in_collection(coll_name)
    raise 'JSON cannot be empty' if JSON.parse(request.body.read).empty?

    raise 'Invalid collection name' unless StorageValidations.collection_name_valid?(coll_name)

    Openws::GeneralDocument
      .new(JSON.parse(request.body.read))
      .with(collection: coll_name)
      .save!
  end
end