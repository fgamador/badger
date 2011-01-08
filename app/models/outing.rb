# == Schema Information
# Schema version: 20110107043851
#
# Table name: outings
#
#  id                :integer         not null, primary key
#  name              :string(255)
#  date              :date
#  nights_of_camping :integer         default(1)
#  long_term_camp    :boolean
#  created_at        :datetime
#  updated_at        :datetime
#

class Outing < ActiveRecord::Base
  validates_presence_of :name, :date, :nights_of_camping
  validates_uniqueness_of :name
  has_many :outing_scouts, :dependent => :destroy
  has_many :scouts, :through => :outing_scouts
  has_many :outing_awards, :dependent => :destroy
  has_many :awards, :through => :outing_awards, :order => "name"

  def num_scouts
    scouts.size
  end

  def unused?
    outing_scouts.empty?
  end
end

