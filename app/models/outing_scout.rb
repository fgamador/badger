# == Schema Information
# Schema version: 20110108231400
#
# Table name: outing_scouts
#
#  id                :integer         not null, primary key
#  outing_id         :integer
#  scout_id          :integer
#  nights_of_camping :integer
#  created_at        :datetime
#  updated_at        :datetime
#

class OutingScout < ActiveRecord::Base
  validates_presence_of :nights_of_camping
  validates_uniqueness_of :scout_id, :scope => :outing_id
  belongs_to :outing
  belongs_to :scout

  def <=> (os)
    outing.date <=> os.outing.date
  end
end

