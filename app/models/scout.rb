# == Schema Information
# Schema version: 20101225051824
#
# Table name: scouts
#
#  id         :integer         not null, primary key
#  first_name :string(255)
#  last_name  :string(255)
#  birthday   :date
#  active     :boolean         default(TRUE)
#  created_at :datetime
#  updated_at :datetime
#

class Scout < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :birthday, :active
  validates :first_name, :presence => true

  has_many :scout_awards, :dependent => :destroy, :order => "earned DESC"
  has_many :awards, :through => :scout_awards, :order => "name"
  has_many :scout_merit_badges, :dependent => :destroy
  has_many :merit_badges, :through => :scout_merit_badges, :order => "name"
  has_many :outing_scouts, :dependent => :destroy
  has_many :outings, :through => :outing_scouts, :order => "date"
  has_many :scout_ranks, :dependent => :destroy
  has_many :ranks, :through => :scout_ranks, :order => "ordinal DESC"
#  named_scope :active, :conditions => { :active => true }

  def add_award(params)
    scout_awards.build(params).save
  end

  def one_per_scout_awards
    awards.select {|award| award.one_per_scout }
  end

  def name
    first_name + " " + last_name
  end

  def rank
    ranks.empty? ? nil : ranks[0];
  end

  def next_rank
    Rank.next_rank rank
  end

  def scout_merit_badges_alphabetical
    scout_merit_badges.sort { |smb1,smb2| smb1.merit_badge.name <=> smb2.merit_badge.name }
  end

  def scout_ranks_descending
    scout_ranks.sort { |sr1,sr2| sr2.rank.ordinal <=> sr1.rank.ordinal }
  end

  def merit_badge_counts
    total = 0
    required = 0
    groups = {}
    scout_merit_badges.each do |smb|
      total += 1
      if smb.merit_badge.eagle_required
        if (smb.merit_badge.group_number)
          if !groups[smb.merit_badge.group_number]
            groups[smb.merit_badge.group_number] = true
            required += 1
          end
        else
          required += 1
        end
      end
    end

    nr = next_rank
    {
      :total => total,
      :total_satisfied => nr && total >= nr.num_merit_badges,
      :required => required,
      :required_satisfied => nr && required >= nr.num_eagle_required
    }
  end

  def nights_of_camping_counts
    long_term_camp_nights = 0
    other_nights = 0
    outing_scouts.each do |os|
      if os.outing.long_term_camp
        long_term_camp_nights += os.nights_of_camping
      else
        other_nights += os.nights_of_camping
      end
    end
    total_nights = long_term_camp_nights + other_nights
    camping_mb_nights = [long_term_camp_nights, 7].min + other_nights
    [ total_nights, camping_mb_nights ]
  end

  def num_ten_noc_awards
    num_awards = 0
    awards.each do |award|
      num_awards += 1 if award == Award.ten_nights_of_camping
    end
    num_awards
  end

  def num_new_ten_noc_awards
    (nights_of_camping_counts[0] / 10) - num_ten_noc_awards
  end

  def <=> (scout)
    last_name <=> scout.last_name || first_name <=> scout.first_name
  end
end

