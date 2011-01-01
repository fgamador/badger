class CreateBadgerConfig < ActiveRecord::Migration
  def self.up
    BadgerConfig.new.save
  end

  def self.down
    BadgerConfig.first.delete
  end
end

