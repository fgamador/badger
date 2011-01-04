class CreateOutings < ActiveRecord::Migration
  def self.up
    create_table :outings do |t|
      t.string :name
      t.date :date
      t.integer :nights_of_camping, :default => 1
      t.boolean :long_term_camp

      t.timestamps
    end
    add_index :outings, :name, :unique => true, :name => "outing_by_name"
  end

  def self.down
    remove_index :outings, :name => "outing_by_name"
    drop_table :outings
  end
end

