class CreateCourtOfHonors < ActiveRecord::Migration
  def self.up
    create_table :court_of_honors do |t|
      t.string :name
      t.date :date
      t.boolean :eagle

      t.timestamps
    end
    add_index :court_of_honors, :name, :unique => true, :name => "coh_by_name"
    add_index :court_of_honors, :date, :unique => true, :name => "coh_by_date"
  end

  def self.down
    remove_index :court_of_honors, :name => "coh_by_name"
    remove_index :court_of_honors, :name => "coh_by_date"
    drop_table :court_of_honors
  end
end

