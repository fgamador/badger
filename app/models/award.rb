# == Schema Information
# Schema version: 20110107043851
#
# Table name: awards
#
#  id            :integer         not null, primary key
#  name          :string(255)
#  one_per_scout :boolean
#  created_at    :datetime
#  updated_at    :datetime
#

class Award < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  has_many :scout_awards, :dependent => :destroy, :order => "earned DESC"
  has_many :outing_awards, :dependent => :destroy

  def self.ten_nights_of_camping
    first
  end

  def active_scout_awards
    scout_awards.select {|sa| sa.scout.active? }
  end

  def num_active_scouts
    unique_scouts = {}
    scout_awards.each do |sa|
      if sa.scout.active?
        unique_scouts[sa.scout] = true
      end
    end
    unique_scouts.size
  end

  def unused?
    scout_awards.empty? && outing_awards.empty?
  end

  def <=> (award)
    name <=> award.name
  end
end

