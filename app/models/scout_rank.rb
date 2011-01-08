# == Schema Information
# Schema version: 20110108060929
#
# Table name: scout_ranks
#
#  id                :integer         not null, primary key
#  scout_id          :integer
#  rank_id           :integer
#  earned            :date
#  court_of_honor_id :integer
#  uncollected       :boolean
#  created_at        :datetime
#  updated_at        :datetime
#

class ScoutRank < ActiveRecord::Base
  validates_uniqueness_of :rank_id, :scope => :scout_id
  belongs_to :scout
  belongs_to :rank
  belongs_to :court_of_honor
end

