class CreateMeritBadges < ActiveRecord::Migration
  def self.up
    create_table :merit_badges do |t|
      t.string :name
      t.boolean :eagle_required
      t.integer :group_number

      t.timestamps
    end
    add_index :merit_badges, :name, :unique => true, :name => "mb_by_name"
  end

  def self.down
    remove_index :merit_badges, :name => "mb_by_name"
    drop_table :merit_badges
  end
end

