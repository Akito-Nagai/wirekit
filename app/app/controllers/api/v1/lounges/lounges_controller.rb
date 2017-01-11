class Api::V1::Lounges::LoungesController < ApplicationController

  # GET /v1/lounges
  def index
    @lounges = Lounge.all
  end

  # GET /v1/lounges/:lounge_id
  def show
    @lounge = Lounge.find_by(uuid: params[:id])
  end

  # POST /v1/lounges
  def create
  end

  # PATCH /v1/lounges/:lounge_id
  def update
  end

  # DELETE /v1/lounges/:lounge_id
  def destroy
    Lounge.find_by(uuid: params[:id]).destroy
  end

end
