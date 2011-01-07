class CreateScoutMeritBadges < ActiveRecord::Migration
  def self.up
    create_table :scout_merit_badges do |t|
      t.references :scout
      t.references :merit_badge
      t.date :earned
      t.references :court_of_honor
      t.boolean :uncollected

      t.timestamps
    end
    add_index :scout_merit_badges, [:scout_id, :merit_badge_id], :unique => true, :name => "smb_by_scout_mb"
  end

  def self.down
    remove_index :scout_merit_badges, :name => "smb_by_scout_mb"
    drop_table :scout_merit_badges
  end
end

