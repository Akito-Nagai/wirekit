# == Schema Information
#
# Table name: attendees
#
#  id                 :integer          not null, primary key
#  uuid               :string           not null
#  lounge_id          :integer          not null
#  name               :text
#  url                :text
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  level              :integer          default("0"), not null
#  status             :integer          default("1"), not null
#  remote_ip          :string
#  user_agent         :text
#  ext1               :text
#  ext2               :text
#  ext3               :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Attendee < ApplicationRecord

  belongs_to :lounge

  has_attached_file :image,
    styles: { medium: '640x640>', small: '320x320>', square: '150x150#', thumb: '75x75#' }
  validates_attachment_size :image, less_than: 1.megabytes,
    message: I18n.t('errors.messages.too_large')
  validates_attachment_content_type :image,
    content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'],
    message: I18n.t('errors.messages.invalid_content_type')

  validates :name, length: { maximum: 30, allow_blank: true }
  validates :url, format: /\A#{URI::regexp(%w(http https))}\z/, allow_blank: true

  scope :online, -> do
    where(status: 1).order(updated_at: :asc)
  end

  before_create -> do
    self.uuid = SecureRandom.uuid
  end

end
