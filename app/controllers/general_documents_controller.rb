# Controller to handle General Document actions
class GeneralDocumentsController < ApplicationController
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

  private

  def persist_in_collection(coll_name)
    raise 'JSON cannot be empty' if JSON.parse(request.body.read).empty?

    Openws::GeneralDocument
      .set_collection_name(coll_name)
      .new(JSON.parse(request.body.read))
      .save!
  end
end
