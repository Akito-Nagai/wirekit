# == Schema Information
#
# Table name: message_attendees
#
#  id          :integer          not null, primary key
#  message_id  :integer          not null
#  attendee_id :integer          not null
#  created_at  :datetime         not null
#

class MessageAttendee < ApplicationRecord

  belongs_to :message
  belongs_to :attendee

end
