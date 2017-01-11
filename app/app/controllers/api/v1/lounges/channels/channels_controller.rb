class Api::V1::Lounges::Channels::ChannelsController < ApplicationController

  # GET /v1/lounges/:lounge_id/channels
  def index
    lounge = Lounge.find_by(uuid: params[:lounge_id])
    @channels = lounge.channels
  end

  # GET /v1/channels/:channel_id
  def show
    @channel = Channel.find_by(uuid: params[:id])
  end

end
