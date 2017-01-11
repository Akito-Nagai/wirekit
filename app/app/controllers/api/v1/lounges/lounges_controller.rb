class Api::V1::Lounges::LoungesController < ApplicationController

  # GET /v1/lounges
  def index
    @lounges = Lounge.all
  end

  # GET /v1/lounges/:lounge_id
  def show
    @lounge = Lounge.find_by(uuid: params[:id])
  end

end
