class CreateRanks < ActiveRecord::Migration
  def self.up
    create_table :ranks do |t|
      t.string :name
      t.integer :ordinal
      t.integer :num_merit_badges, :default => 0
      t.integer :num_eagle_required, :default => 0

      t.timestamps
    end
    add_index :ranks, :name, :unique => true, :name => "rank_by_name"
    add_index :ranks, :ordinal, :unique => true, :name => "rank_by_ordinal"
  end

  def self.down
    remove_index :ranks, :name => "rank_by_name"
    remove_index :ranks, :name => "rank_by_ordinal"
    drop_table :ranks
  end
end

