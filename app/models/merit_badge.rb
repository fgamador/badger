class MeritBadge < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
=begin
  has_many :scout_merit_badges, :dependent => :destroy, :order => "earned DESC"

  def active_scout_merit_badges
    scout_merit_badges.select {|smb| smb.scout.active? }
  end

  def num_active_scouts
    active_scout_merit_badges.size
  end

  def owner
    if eagle_required
      return nil
    end

    smbs = active_scout_merit_badges
    smbs.size == 1 ? smbs.first.scout : nil
  end
=end

  def <=> (merit_badge)
    name <=> merit_badge.name
  end
end

