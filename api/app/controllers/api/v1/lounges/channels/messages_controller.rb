class Api::V1::Lounges::Channels::MessagesController < ApplicationController

  # GET /v1/channels/:channel_id/channel_messages
  def index
    channel = Channel.find_by(uuid: params[:id])
    @messages = channel.messages
  end

  # GET /v1messages/:message_id
  def show
    @message = Message.find_by(uuid: params[:id])
  end

end
