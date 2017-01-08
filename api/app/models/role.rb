# == Schema Information
#
# Table name: roles
#
#  id          :integer          not null, primary key
#  code        :string           not null
#  name        :string           default(""), not null
#  policy      :text             default(""), not null
#  description :text             default(""), not null
#  sort        :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Role < ApplicationRecord

  default_scope { order sort: :asc }

  has_many :users_roles, dependent: :destroy
  has_many :users, through: :users_roles

  validates :code, presence: true
  validates :code, length: { maximum: 100 }
  validates :code, uniqueness: true, allow_blank: true
  validates :name, presence: true
  validates :name, length: { maximum: 100 }
  validates :name, format: { with: /\A[^\.\/]+\z/ }, allow_blank: true
  validates :name, uniqueness: true, allow_blank: true
  validates :description, length: { maximum: 200 }

  def to_s
    name
  end

  def permit?(url_path)
    true # TODO
  end

end
