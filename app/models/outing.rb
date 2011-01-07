class Outing < ActiveRecord::Base
  validates_presence_of :name, :date, :nights_of_camping
  validates_uniqueness_of :name
#  has_many :scout_outings, :dependent => :destroy
#  has_many :scouts, :through => :scout_outings
#  has_many :outing_awards, :dependent => :destroy
#  has_many :awards, :through => :outing_awards, :order => "name"
end

