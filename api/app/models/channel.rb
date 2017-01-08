# == Schema Information
#
# Table name: channels
#
#  id                 :integer          not null, primary key
#  uuid               :string           not null
#  lounge_id          :integer          not null
#  name               :string
#  description        :text
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Channel < ApplicationRecord

  belongs_to :lounge
  has_many :messages, dependent: :destroy
  has_many :channel_attendees, dependent: :destroy
  has_many :attendees, through: :channel_attendees

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

end
