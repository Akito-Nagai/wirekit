class Api::V1::Lounges::Channels::AttendeesController < ApplicationController

  # GET /v1/channels/:channel_id/channel_attendees
  def index
    channel = Channel.find_by(uuid: params[:id])
    @attendees = channel.attendees
  end

  # GET /v1/channel_attendees/:channel_attendee_id
  def show
    @attendee = ChannelAttendee.find_by(uuid: params[:id])
  end

end
