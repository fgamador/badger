class CreateBadgerConfig < ActiveRecord::Migration
  def self.up
    BadgerConfig.create!
  end

  def self.down
    BadgerConfig.first.destroy
  end
end

