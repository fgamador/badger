class Rank < ActiveRecord::Base
  validates_presence_of :name, :ordinal
  validates_uniqueness_of :name
  validates_uniqueness_of :ordinal
=begin
  has_many :scout_ranks, :dependent => :destroy, :order => "earned DESC"

  def self.next_rank(rank)
    next_rank_num = (rank == nil) ? 0 : rank.ordinal + 1
    Rank.first(:conditions => ["ordinal = ?", next_rank_num])
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
=end

  def <=> (rank)
    ordinal <=> rank.ordinal
  end
end

