class AddReferenceUrlSuffixToRanks < ActiveRecord::Migration
  def self.up
    add_column :ranks, :reference_url_suffix, :string
  end

  def self.down
    remove_column :ranks, :reference_url_suffix
  end
end

