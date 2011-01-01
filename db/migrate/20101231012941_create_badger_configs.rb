class CreateBadgerConfigs < ActiveRecord::Migration
  def self.up
    create_table :badger_configs do |t|
      t.string :login
      t.string :hashed_password
      t.string :admin_login
      t.string :hashed_admin_password

      t.timestamps
    end
  end

  def self.down
    drop_table :badger_configs
  end
end

