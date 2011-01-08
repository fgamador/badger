class CreateOutingScouts < ActiveRecord::Migration
  def self.up
    create_table :outing_scouts do |t|
      t.references :outing
      t.references :scout
      t.integer :nights_of_camping

      t.timestamps
    end
    add_index :outing_scouts, [:outing_id, :scout_id], :unique => true, :name => "os_by_outing_scout"
  end

  def self.down
    remove_index :outing_scouts, :name => "os_by_outing_scout"
    drop_table :outing_scouts
  end
end

