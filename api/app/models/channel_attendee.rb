# == Schema Information
#
# Table name: channel_attendees
#
#  id          :integer          not null, primary key
#  uuid        :string           not null
#  channel_id  :integer          not null
#  attendee_id :integer          not null
#  created_at  :datetime         not null
#

class ChannelAttendee < ApplicationRecord

  belongs_to :channel, touch: true
  belongs_to :attendee
  has_many :messages, dependent: :destroy

  before_create -> do
    self.uuid = SecureRandom.uuid
  end

  after_create -> do
    # WebsocketRails[uuid].trigger :enter_channel, 'Entered'
  end

  after_destroy -> do
    # WebsocketRails[uuid].trigger :leave_channel, 'Leaved'
  end

end
