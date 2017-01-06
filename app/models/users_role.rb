# == Schema Information
#
# Table name: users_roles
#
#  id      :integer          not null, primary key
#  user_id :integer          not null
#  role_id :integer          not null
#

class UsersRole < ApplicationRecord

  belongs_to :user
  belongs_to :role

end
