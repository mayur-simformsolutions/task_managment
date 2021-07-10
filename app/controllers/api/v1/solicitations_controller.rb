class Api::V1::SolicitationsController < Api::V1::AuthenticatedController
  before_action :set_solicitation, only: [:show, :update, :destroy]

  def index
    begin
      solicitations = Solicitation.all
    rescue => e
      render_exception(e, 422) && return
    end
    json_response(SolicitationSerializer.new(solicitations).serializable_hash[:data].map {|solicitation| solicitations[:attributes]})
  end

  def create
    begin
      solicitation = Solicitation.create!(solicitation_params)
    rescue => e 
      render_exception(e, 422) && return
    end
    json_response(SolicitationSerializer.new(solicitation).serializable_hash[:data][:attributes])
  end

  def show
    json_response(SolicitationSerializer.new(@solicitation).serializable_hash[:data][:attributes])
  end

  def update
    begin
      @solicitation.update!(solicitation_params)
    rescue => e 
      render_exception(e, 422) && return
    end
    json_response(SolicitationSerializer.new(@solicitation).serializable_hash[:data][:attributes])
  end

  def destroy
    begin
      @solicitation.destroy
    rescue => e 
      render_exception(e, 422) && return
    end
    render json: { success: true, data: {}, errors: [] }, status: 200
  end
  
  private
  def solicitation_params
    params.require(:solicitation).permit(:name, :description)
  end

  def set_solicitation
    @solicitation = Solicitation.find(params[:id])
  end
end
