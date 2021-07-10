# frozen_string_literal: true
class Api::V1::LabelsController < Api::V1::AuthenticatedController
  before_action :set_label, only: [:update, :destroy]

  def index
    begin
      label = Label.all
    rescue => e
      render_exception(e, 422) && return
    end
    json_response(LabelSerializer.new(label).serializable_hash[:data].map {|label| label[:attributes]})
  end

  def create
    begin
      label = Label.create!(label_params)
    rescue => e 
      render_exception(e, 422) && return
    end
    json_response(LabelSerializer.new(label).serializable_hash[:data][:attributes])
  end

  def show
    json_response(LabelSerializer.new(@label).serializable_hash[:data][:attributes])
  end

  def update
    begin
      @label.update!(label_params)
    rescue => e 
      render_exception(e, 422) && return
    end
    json_response(LabelSerializer.new(@label).serializable_hash[:data][:attributes])
  end

  def destroy
    begin
      @label.destroy
    rescue => e 
      render_exception(e, 422) && return
    end
    render json: { success: true, data: {}, errors: [] }, status: 200
  end

  private
  def label_params
    params.require(:label).permit(:name)
  end

  def set_label
    @label = Label.find(params[:id])
  end
end
