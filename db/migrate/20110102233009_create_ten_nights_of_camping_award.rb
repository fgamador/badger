class CreateTenNightsOfCampingAward < ActiveRecord::Migration
  def self.up
    Award.create! :name => "10 Nights of Camping"
  end

  def self.down
    Award.first.destroy
  end
end

