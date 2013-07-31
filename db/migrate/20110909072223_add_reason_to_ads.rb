class AddReasonToAds < ActiveRecord::Migration
  def self.up
    add_column :ads, :reason, :string
  end

  def self.down
    remove_column :ads, :reason
  end
end
