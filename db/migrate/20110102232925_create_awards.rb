class CreateAwards < ActiveRecord::Migration
  def self.up
    create_table :awards do |t|
      t.string :name
      t.boolean :one_per_scout

      t.timestamps
    end
    add_index :awards, :name, :unique => true, :name => "award_by_name"
  end

  def self.down
    remove_index :awards, :name => "award_by_name"
    drop_table :awards
  end
end

