# frozen_string_literal: true
class Api::V1::LabelsController < Api::V1::AuthenticatedController
  before_action :set_label, only: [:update, :destroy]

  # GET /api/labels
  def index
    begin
      labels = Label.all
    rescue => e
      render_exception(e, 422) && return
    end
    json_response(LabelSerializer.new(labels).serializable_hash[:data].map {|label| label[:attributes]})
  end

  # POST /api/labels
  def create
    begin
      label = Label.create!(label_params)
    rescue => e 
      render_exception(e, 422) && return
    end
    json_response(LabelSerializer.new(label).serializable_hash[:data][:attributes])
  end

  # GET /api/labels/:id
  def show
    json_response(LabelSerializer.new(@label).serializable_hash[:data][:attributes])
  end

  # PUT /api/labels/:id
  def update
    begin
      @label.update!(label_params)
    rescue => e 
      render_exception(e, 422) && return
    end
    json_response(LabelSerializer.new(@label).serializable_hash[:data][:attributes])
  end

  # DELETE /api/labels/:id
  def destroy
    begin
      @label.destroy
    rescue => e 
      render_exception(e, 422) && return
    end
    render json: { success: true, data: {}, errors: [] }, status: 200
  end

  # Private methods
  private
  def label_params
    params.require(:label).permit(:name)
  end

  def set_label
    @label = Label.find(params[:id])
  end
end
