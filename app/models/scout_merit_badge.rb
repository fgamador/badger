# == Schema Information
# Schema version: 20110107043851
#
# Table name: scout_merit_badges
#
#  id                :integer         not null, primary key
#  scout_id          :integer
#  merit_badge_id    :integer
#  earned            :date
#  court_of_honor_id :integer
#  uncollected       :boolean
#  created_at        :datetime
#  updated_at        :datetime
#

class ScoutMeritBadge < ActiveRecord::Base
  validates_uniqueness_of :merit_badge_id, :scope => :scout_id
  belongs_to :scout
  belongs_to :merit_badge
  belongs_to :court_of_honor
end

