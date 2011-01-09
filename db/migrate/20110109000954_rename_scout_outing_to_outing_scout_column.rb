class RenameScoutOutingToOutingScoutColumn < ActiveRecord::Migration
  def self.up
    rename_column :scout_awards, :scout_outing_id, :outing_scout_id
  end

  def self.down
    rename_column :scout_awards, :outing_scout_id, :scout_outing_id
  end
end

