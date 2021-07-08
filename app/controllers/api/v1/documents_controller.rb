# frozen_string_literal: true
class Api::V1::DocumentsController < Api::V1::AuthenticatedController
  before_action :set_document, only: [:update, :destroy]

  def index
    begin
      documents = Document.all
    rescue => e
      render_exception(e, 422) && return
    end
    json_response(DocumentSerializer.new(documents).serializable_hash[:data].map {|document| document[:attributes]})
  end

  def create
    begin
      document = Document.create!(document_params)
    rescue => e 
      render_exception(e, 422) && return
    end
    json_response(DocumentSerializer.new(document).serializable_hash[:data][:attributes])
  end

  def update
    begin
      @document.update!(document_params)
    rescue => e 
      render_exception(e, 422) && return
    end
    json_response(DocumentSerializer.new(@document).serializable_hash[:data][:attributes])
  end

  def destroy
    begin
      @document.destroy
    rescue => e 
      render_exception(e, 422) && return
    end
    render json: { success: true, data: {}, errors: [] }, status: 200
  end

  private
  def document_params
    params.require(:document).permit(:name)
  end

  def set_document
    @document = Document.find(params[:id])
  end
end
