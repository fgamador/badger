class CreateScoutAwards < ActiveRecord::Migration
  def self.up
    create_table :scout_awards do |t|
      t.references :scout
      t.references :award
      t.references :scout_outing
      t.date :earned
      t.references :court_of_honor
      t.boolean :uncollected

      t.timestamps
    end
  end

  def self.down
    drop_table :scout_awards
  end
end

