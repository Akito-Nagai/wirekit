# == Schema Information
#
# Table name: lounges
#
#  id                 :integer          not null, primary key
#  uuid               :string           not null
#  user_id            :integer          not null
#  name               :string
#  description        :text
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Lounge < ApplicationRecord

  include Garage::Representer
  include Garage::Authorizable
  property :id
  property :uuid
  property :name
  property :description
  property :created_at
  property :updated_at
  link(:self) { v1_lounge_url(self.id) }

  belongs_to :user
  has_many :attendees, dependent: :destroy
  has_many :channels, dependent: :destroy

  has_attached_file :image,
    styles: { medium: '640x640>', small: '320x320>', square: '150x150#', thumb: '75x75#' }
  validates_attachment_size :image, less_than: 1.megabytes,
    message: I18n.t('errors.messages.too_large')
  validates_attachment_content_type :image,
    content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'],
    message: I18n.t('errors.messages.invalid_content_type')

  validates :name, length: { maximum: 30, allow_blank: true }
  validates :name, uniqueness: { allow_blank: true }
  validates :description, length: { maximum: 1000, allow_blank: true }

  before_create -> do
    self.uuid = SecureRandom.uuid
  end

  # Permissins for API (:index)
  def self.build_permissions(perms, _other, _target)
    perms.permits! :read
  end

  # Permissins for API (:show, :create, :update, :destroy)
  def build_permissions(perms, _other)
    perms.permits! :read
  end

  # 入室させる
  def enter(attendee_uuid = nil)
    if attendee_uuid
      attendee = attendees.find_by(uuid: attendee_uuid)
      attendee.update!(status: 1)
    end
    unless attendee
      logger.info 'New attendee.'
      attendee = attendees.create!(name: 'test')
    end
    logger.info "Enter lounge(#{uuid}) attendee(#{attendee_uuid})"
    # WebsocketRails[uuid].trigger :enter_lounge, 'Entered'
    attendee
  end

  # 退室させる
  def leave(attendee_uuid)
    attendee = attendees.find_by(uuid: attendee_uuid)
    attendee.update!(status: 0)
    logger.info "Leave lounge(#{uuid}) attendee(#{attendee_uuid})"
    # WebsocketRails[uuid].trigger :leave_lounge, 'Leaved'
    attendee
  end

end
