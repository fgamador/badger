class CreateOutingAwards < ActiveRecord::Migration
  def self.up
    create_table :outing_awards do |t|
      t.references :outing
      t.references :award

      t.timestamps
    end
    add_index :outing_awards, [:outing_id, :award_id], :unique => true, :name => "oa_by_outing_award"
  end

  def self.down
    remove_index :outing_awards, :name => "oa_by_outing_award"
    drop_table :outing_awards
  end
end

