# == Schema Information
# Schema version: 20110107043851
#
# Table name: court_of_honors
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  date       :date
#  eagle      :boolean
#  created_at :datetime
#  updated_at :datetime
#

class CourtOfHonor < ActiveRecord::Base
  validates_presence_of :name, :date
  validates_uniqueness_of :name
  validates_uniqueness_of :date
  has_many :scout_awards, :dependent => :nullify
  has_many :scout_merit_badges, :dependent => :nullify
  has_many :scout_ranks, :dependent => :nullify

  def self.first_after(date)
    prev = nil;
    all(:order => "date DESC").each do |coh|
      return prev if coh.date < date
      prev = coh
    end
    prev
  end

  def unused?
    scout_awards.empty? && scout_merit_badges.empty? && scout_ranks.empty?
  end
end

