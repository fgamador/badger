# == Schema Information
# Schema version: 20110107043851
#
# Table name: ranks
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  ordinal            :integer
#  num_merit_badges   :integer         default(0)
#  num_eagle_required :integer         default(0)
#  created_at         :datetime
#  updated_at         :datetime
#

class Rank < ActiveRecord::Base
  validates_presence_of :name, :ordinal
  validates_uniqueness_of :name
  validates_uniqueness_of :ordinal
  has_many :scout_ranks, :dependent => :destroy, :order => "earned DESC"

  def self.next_rank(rank)
    next_rank_num = (rank == nil) ? 0 : rank.ordinal + 1
    Rank.first(:conditions => ["ordinal = ?", next_rank_num])
  end

  def active_scout_ranks
    scout_ranks.select {|sr| sr.scout.active? }
  end

  def num_active_scouts
    count = 0
    scout_ranks.each do |sr|
      if sr.scout.active? && sr.scout.rank == self
        count += 1
      end
    end
    count
  end

  def num_scouts
    scout_ranks.size
  end

  def unused?
    scout_ranks.empty? 
  end

  def <=> (rank)
    ordinal <=> rank.ordinal
  end
end

