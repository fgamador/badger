class CourtOfHonor < ActiveRecord::Base
  validates_presence_of :name, :date
  validates_uniqueness_of :name
  validates_uniqueness_of :date
#  has_many :scout_awards, :dependent => :nullify
#  has_many :scout_merit_badges, :dependent => :nullify
#  has_many :scout_ranks, :dependent => :nullify
end

