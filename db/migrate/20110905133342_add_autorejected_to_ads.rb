class AddAutorejectedToAds < ActiveRecord::Migration
  def self.up
    add_column :ads, :autorejected, :boolean, :default => 0
  end

  def self.down
    remove_column :ads, :autorejected
  end
end
