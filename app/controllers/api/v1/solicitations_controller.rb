# frozen_string_literal: true
class Api::V1::SolicitationsController < Api::V1::AuthenticatedController
  before_action :set_solicitation, only: [:show, :update, :destroy]

  # GET /api/solicitations
  def index
    begin
      solicitations = Solicitation.all
    rescue => e
      render_exception(e, 422) && return
    end
    json_response(SolicitationSerializer.new(solicitations).serializable_hash[:data].map {|solicitation| solicitation[:attributes]})
  end

  # POST /api/solicitations
  def create
    begin
      solicitation = Solicitation.create!(solicitation_params)
    rescue => e 
      render_exception(e, 422) && return
    end
    json_response(SolicitationSerializer.new(solicitation).serializable_hash[:data][:attributes])
  end

  # GET /api/solicitations/:id
  def show
    json_response(SolicitationSerializer.new(@solicitation).serializable_hash[:data][:attributes])
  end

  # PUT /api/solicitations/:id
  def update
    begin
      @solicitation.update!(solicitation_params)
    rescue => e 
      render_exception(e, 422) && return
    end
    json_response(SolicitationSerializer.new(@solicitation).serializable_hash[:data][:attributes])
  end

  # DELETE /api/solicitations/:id
  def destroy
    begin
      @solicitation.destroy
    rescue => e 
      render_exception(e, 422) && return
    end
    render json: { success: true, data: {}, errors: [] }, status: 200
  end
  
  # Private methods
  private
  def solicitation_params
    params.require(:solicitation).permit(:name, :description)
  end

  def set_solicitation
    @solicitation = Solicitation.find(params[:id])
  end
end
