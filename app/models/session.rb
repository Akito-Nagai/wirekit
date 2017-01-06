# == Schema Information
#
# Table name: sessions
#
#  id         :integer          not null, primary key
#  session_id :string           not null
#  data       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

#= Session

class Session < ApplicationRecord

  # Session Expiry
  def self.sweep(updated: 5.hour, created: 5.days)
    if updated.is_a?(String)
      updated = updated.split.inject { |count, unit| count.to_i.send(unit) }
    end
    if created.is_a?(String)
      created = created.split.inject { |count, unit| count.to_i.send(unit) }
    end
    delete_all "updated_at < '#{updated.ago.to_s(:db)}' OR created_at < '#{created.ago.to_s(:db)}'"
  end

end
