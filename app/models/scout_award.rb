# == Schema Information
# Schema version: 20110109000954
#
# Table name: scout_awards
#
#  id                :integer         not null, primary key
#  scout_id          :integer
#  award_id          :integer
#  outing_scout_id   :integer
#  earned            :date
#  court_of_honor_id :integer
#  uncollected       :boolean
#  created_at        :datetime
#  updated_at        :datetime
#

class ScoutAward < ActiveRecord::Base
  belongs_to :scout
  belongs_to :award
  belongs_to :outing_scout
  belongs_to :court_of_honor
end

