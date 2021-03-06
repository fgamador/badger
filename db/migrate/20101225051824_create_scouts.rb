class CreateScouts < ActiveRecord::Migration
  def self.up
    create_table :scouts do |t|
      t.string :first_name
      t.string :last_name
      t.date :birthday
      t.boolean :active, :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :scouts
  end
end
