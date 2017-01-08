# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  nick_name              :string           default(""), not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string
#  locked_at              :datetime
#  image_file_name        :string
#  image_content_type     :string
#  image_file_size        :integer
#  image_updated_at       :datetime
#  bio                    :text
#  note                   :text
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ApplicationRecord
  default_scope { order created_at: :desc }
  scope :enabled, -> { where 'confirmed_at is not null' }

  has_many :users_roles, dependent: :destroy
  has_many :roles, through: :users_roles

#  devise :database_authenticatable, :registerable,
#         :recoverable, :rememberable, :trackable, :validatable,
#         :confirmable, :omniauthable, :lockable

  has_attached_file :image,
    processors: [:thumbnail],
    styles: { avater_lg: '256x256#', avater_sm: '48x48#' }
  validates_attachment_size :image, less_than: 5.megabytes,
    message: I18n.t('activerecord.errors.messages.too_large')
  validates_attachment_content_type :image,
    content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'],
    message: I18n.t('activerecord.errors.messages.invalid_content_type')

  # 表示名
  def screen_name
    if nick_name.present?
      return nick_name
    else
      email =~ /(.*)@.*/
      return $1
    end
  end
  def to_s
    screen_name
  end

  # 権限あり？
  def has_role?(role_code = :any)
    if role_code == :any
      ! roles.empty?
    else
      roles.find_by(code: role_code.to_s) ? true : false
    end
  end

  def permit?(url_path)
    roles_a = roles.to_a
    roles_a.blank? ||
      roles_a.keep_if { |role| role.permit?(url_path) }.present?
  end

end
