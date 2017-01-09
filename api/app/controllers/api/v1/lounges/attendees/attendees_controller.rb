class Api::V1::Lounges::Attendees::AttendeesController < ApplicationController

  # GET /v1/lounges/:lounge_id/lounge_attendees
  def index
    lounge = Lounge.find_by(uuid: params[:id])
    @attendees = lounge.attendees
  end

  # GET /v1/attendees/:attendee_id
  def show
    @attendee = Attendee.find_by(uuid: params[:id])
  end

end
