class CreateScoutRanks < ActiveRecord::Migration
  def self.up
    create_table :scout_ranks do |t|
      t.references :scout
      t.references :rank
      t.date :earned
      t.references :court_of_honor
      t.boolean :uncollected

      t.timestamps
    end
    add_index :scout_ranks, [:scout_id, :rank_id], :unique => true, :name => "sr_by_scout_rank"
  end

  def self.down
    remove_index :scout_ranks, :name => "sr_by_scout_rank"
    drop_table :scout_ranks
  end
end

