class Api::V1::Lounges::Channels::ChannelsController < Api::V1::BaseController

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
