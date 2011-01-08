# == Schema Information
# Schema version: 20110108224701
#
# Table name: outing_awards
#
#  id         :integer         not null, primary key
#  outing_id  :integer
#  award_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

class OutingAward < ActiveRecord::Base
  validates_uniqueness_of :award_id, :scope => :outing_id
  belongs_to :outing
  belongs_to :award
end

