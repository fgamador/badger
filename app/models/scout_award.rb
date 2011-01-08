class ScoutAward < ActiveRecord::Base
  belongs_to :scout
  belongs_to :award
  belongs_to :scout_outing
  belongs_to :court_of_honor
end
