class Api::V1::Lounges::AttendeesController < Api::V1::BaseController

  def model
    Attendee
  end

  # GET /v1/lounges/:lounge_id/lounge_attendees
  def index
    lounge = Lounge.find_by(uuid: params[:lounge_id])
    @records = lounge.attendees
  end

  # POST /v1/lounges/:lounge_id/lounge_attendees
  def create
    lounge = Lounge.find_by(uuid: params[:lounge_id])
    @record = lounge.attendees.create!(request_data)
    publish('public', type: 'entered')
    render :show
  end

end
