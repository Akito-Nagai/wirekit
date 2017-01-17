class Api::V1::Lounges::Attendees::AttendeesController < Api::V1::BaseController

  def model
    Attendee
  end

  # GET /v1/lounges/:lounge_id/lounge_attendees
  def index
    lounge = Lounge.find_by(uuid: params[:id])
    @records = lounge.attendees
  end

end
