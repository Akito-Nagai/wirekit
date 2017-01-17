class Api::V1::Lounges::Channels::AttendeesController < Api::V1::BaseController

  def model
    ChannelAttendee
  end

  # GET /v1/channels/:channel_id/channel_attendees
  def index
    channel = Channel.find_by(uuid: params[:id])
    @records = channel.attendees
  end

end
