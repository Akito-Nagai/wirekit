class Api::V1::Lounges::Channels::MessagesController < Api::V1::BaseController

  def model
    Message
  end

  # GET /v1/channels/:channel_id/channel_messages
  def index
    channel = Channel.find_by(uuid: params[:id])
    @records = channel.messages
  end

end
