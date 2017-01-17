class Api::V1::Lounges::Channels::ChannelsController < Api::V1::BaseController

  def model
    Channel
  end

  # GET /v1/lounges/:lounge_id/channels
  def index
    lounge = Lounge.find_by(uuid: params[:lounge_id])
    @records = lounge.channels
  end

end
